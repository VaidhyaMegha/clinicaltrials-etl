package com.amazonaws.lambda.demo;

import routines.system.api.TalendJob;

public class TalendJobFactory {
	
	public static TalendJob getTalendJob(String jobClassName) {
		try {
			return (TalendJob) Class.forName(jobClassName).newInstance();
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

}
