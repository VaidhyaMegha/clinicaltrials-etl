package com.amazonaws.lambda.demo;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.google.gson.Gson;

import routines.system.api.TalendESBJobFactory;
import routines.system.api.TalendJob;

public class LambdaFunctionHandler implements RequestHandler<S3Event, String> {

    private AmazonS3 s3 = AmazonS3ClientBuilder.standard().build();

    public LambdaFunctionHandler() {}

    // Test purpose only.
    LambdaFunctionHandler(AmazonS3 s3) {
        this.s3 = s3;
    }

    @Override
    public String handleRequest(S3Event event, Context context) {
        context.getLogger().log("Received event: " + event);

        // Get the object from the event and show its content type
        String bucket = event.getRecords().get(0).getS3().getBucket().getName();
        String key = event.getRecords().get(0).getS3().getObject().getKey();
        Gson gson = new Gson();
        
        String[] var;
        try {
            S3Object response = s3.getObject(new GetObjectRequest(bucket, key));
            String contentType = response.getObjectMetadata().getContentType();
            context.getLogger().log("CONTENT TYPE: " + contentType);
            
            
            var = new String[] {"--context_param INPUT_FILE=" + key ,
            		"--context_param OUTPUT_FILE=test-output/" + key,
            		"--context_param BUCKET=" + bucket+ "",
            		"--context_param REGION=us-east-1" }; 
            
            context.getLogger().log("var: " + gson.toJson(var));
            
            // passing  input file name as pre-defined context variable (input) in your Talend job
            TalendJob job = TalendJobFactory.getTalendJob("da_etl_641.s3_test_0_1.S3_Test");
            String[][] bufferOutput = job.runJob(var); // Executing your Talend Job
            

            String output = gson.toJson(bufferOutput);
            
            return gson.toJson(var) + "-----" + contentType + " --- " + output;
        } catch (Exception e) {
            e.printStackTrace();
            context.getLogger().log(String.format(
                "Error getting object %s from bucket %s. Make sure they exist and"
                + " your bucket is in the same region as this function.", key, bucket));
            throw e;
        }
    }
}
