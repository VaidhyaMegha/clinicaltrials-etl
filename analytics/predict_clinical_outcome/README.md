# Results
[Predict Clinical Trial Outcome based on study design](screenshots/VaidhyaMegha-ML-1-v1.jpg)

# References
- https://aws.amazon.com/aml/faqs/
    

        Q: What algorithm does Amazon Machine Learning use to generate models?
        Amazon Machine Learning currently uses an industry-standard logistic regression algorithm to generate models.

        Q: Can I export my models out of Amazon Machine Learning?
        No.
         
        Q: Can I import existing models into Amazon Machine Learning?
        No.
        
- https://aws.amazon.com/aml/pricing/

        
        Data Analysis and Model Building Fees
        
        $0.42 per Hour
        
        Batch Predictions
        
        $0.10 per 1,000 predictions, rounded up to the next 1,000
        
        Real-Time Predictions
        
        $0.0001 per prediction, rounded up to the nearest penny
        
- https://aws.amazon.com/blogs/machine-learning/amazon-sagemaker-supports-knn-classification-and-regression/      
- https://aws.amazon.com/sagemaker/faqs/
        
        
        Q: What algorithms does Amazon SageMaker use to generate models?
        
        Amazon SageMaker includes built-in algorithms for linear regression, logistic regression, k-means clustering, 
        principal component analysis, factorization machines, neural topic modeling, latent dirichlet allocation, 
        gradient boosted trees, sequence2sequence, time series forecasting, word2vec, and image classification.
        Amazon SageMaker also provides optimized Apache MXNet, Tensorflow, Chainer, and PyTorch containers. 
        In addition, Amazon SageMaker supports your custom training algorithms provided through a Docker 
        image adhering to the documented specification.
        

        Q: When should I use reinforcement learning?
        
        While the goal of supervised learning techniques is to find the right answer based on the patterns in the
        training data and the goal of unsupervised learning techniques is to find similarities and differences 
        between data points. In contrast, the goal of reinforcement learning techniques is to learn how to achieve a
         desired outcome even when it is not clear how to accomplish that outcome. 
        As a result, RL is more suited to enabling intelligent applications where an agent can make autonomous 
        decisions such as robotics, autonomous vehicles, HVAC, industrial control, and more.
        
        
        Q: What is Amazon SageMaker Neo?
        
        Amazon SageMaker Neo is a new capability that enables machine learning models to train once and run anywhere 
        in the cloud and at the edge. SageMaker Neo automatically optimizes models built with popular deep learning frameworks 
        that can be used to deploy on multiple hardware platforms. Optimized models run up to two times faster and 
        consume less than a tenth of the resources of typical machine learning models.
        
        Q: Which models does SageMaker Neo support?
        
        Currently, SageMaker Neo supports the most popular deep learning models that power computer vision applications 
        and the most popular decision tree models used in Amazon SageMaker today. Neo optimizes the performance of 
        AlexNet, ResNet, VGG, Inception, MobileNet, SqueezeNet, and DenseNet models trained in MXNet and TensorFlow,
        and classification and random cut forest models trained in XGBoost.
        
        Q: What if I have my own notebook, training, or hosting environment?
        
        Amazon SageMaker provides a full end-to-end workflow, but you can continue to use your existing tools with
        Amazon SageMaker. You can easily transfer the results of each stage in and out 
        of Amazon SageMaker as your business requirements dictate.
        
- Apache MXNet
        
        
        https://mxnet.incubator.apache.org/tutorials/java/mxnet_java_on_intellij.html
        https://github.com/apache/incubator-mxnet/blob/master/scala-package/mxnet-demo/java-demo/src/main/java/mxnet/ObjectDetection.java