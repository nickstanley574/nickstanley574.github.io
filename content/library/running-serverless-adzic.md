---
layout: default
build:
  list: false
---
# Running Serverless 

By: Gojki Adzic - ISBN: 978-0-9930881-5-5 - Published On: 2019-06-01

Serverless platforms are still rapidly evolving, and AWS is doing something important with Lambdas every few months. This version of the book captures the sate of the platform as of June 2019.

# 1. Serverless in five minutes 

Explains the financial and technical constraints of server deployments.

Serverless application are software that runs in an environment where the hosting provider is fully responsible for the infrastructural  and operational task such as receiving network request, scaling on demand, monitoring and recovery. 

The buzzword 'serverless' is a horrible marketing term, and the internet is full of jokes about how there are still servers in serverless environment.

AWS Lambda is serverless in that, there are virtual and physical machines running in the background, but you the users don't really need to care about them. 

🗨️ - The application is serverless if your workflow doesn't include server configurations. From the perspective of the company there are no servers. 

The two big Benefits:
 - Shorter time to market
 - Reduce Operational costs

## The serverless pricing model

You pay for the **actual usage**, not for **reserved capacity**. If the app isn't doing much, you don't pay. If millions of user appear, Lambda will spin up resources to handle the requests, charge you the increased usage, and remove the resources when no longer needed. 

Lambda pricing depends on 2 factors:  
- The max memory for a task
- The time spend executing

## Important AWS Lambda Technical constraints

- No session affinity: Lambda will decided whether it needs to create new resources to handle requests, and when to reuse and old resource and when to drop it. There is no way to control request routing to ensure that requests from same source arrive in sequence to the same destination. There are no guarantees about preserving state across requests and developers have no control over the routing.  
- Non-deterministic latency: Lambda is optimized for max throughput, not for minimizing latency.
- Execution time limited to 15 minutes
- no direct control over processing power: The only container choice you can make is the amount of memory from 128 MB to 3 GB.

<hr>

# **Part 1 Basic development tasks** 

<hr>

# 2. Set up tools for local development 

The AWS Serverless Application Model (SAM) is a set of products that simplify developing, testing and deploying apps using Lambda. 

The SAM command line tools are a set of Python scripts, so you will need the Python runtime installed.

The book uses JavaScript with Node.js for developing Lambdas. You do no need Node.js to work with SAM in a different language, but you will need the appropriate tools for that language. 

# 3. Create a web service
This chapter introduces the basic workflow for serverless deployments. 

Ti create a simple SAM project in a new subdirectory rum:
```
sam init --runtime nodejs10.x --name app
```

## Infrastructure as code

For deploying apps, Sam uses CloudFormation, an AWS service for managing infrastructure as code. CloudFormation converts a source file describing a infrastructure (called a template) into a set of running configured resources (called a stack).

We can use CloudFormation to create a whole stack of resource from the template in a single command.

**Do no set resource names** - CloudFormation allows you to specify name for many resource types including functions, using the `Name` property. Unless there is VERY specific reason why you need this, avoid setting physical names. Letting AWS set random names make it easy to create several stacks based on the same template and avoid resource naming conflicts.

In early 2016 before SAM a lambda has 20 lines of code but required 200 lines of config scripts. With SAM we can achieve the same thing in just 10-15 lines of CloudFormation templates. 

## The Lambda programming model

All Lambda functions have two arguments: 
- `event` represent the data sent by the client invoking the function
- `context` contains information about the runtime environment. 

### Lambda interfaces in strongly type languages  

In strongly typed languages you can set up functions with specific request types and interfaces. In languages without strong typing, like JavaScript or Python, these objects are mostly native key-value dictionaries or hash-maps.

## Deploying SAM applications

Turning a SAM app on your disk into AWS resources require 3 steps:
1. Build -- Create a clean copy of all Lambda functions, remove test and development resources, and download dependencies.
2. Package -- Bundle each function into a self-contained ZIP archive and upload to S3 and produce a copy of the source app template that point to remove resources instead of local directories. 
3. Deploy -- Upload the package template to CloudFormation, and execute the change to create a running environment. 

## Inspecting a stack 

The easiest way to insect a stack is with the AWS Web Console.  The **resources** section contains a list of all the AWS resources Cloudformation created for a stack. The **Outputes** section contains a list of stack results. 

The other way from the command line: 
```
aws cloudformation describe-stacks --stack-name sam-test-1
```

# 4. Development and troubleshooting 

This chapter explain the basic monitoring and logging of Lambdas to help with troubleshooting. **Also learn hot to simulate AWS services locally.**

CloudWatch, another AWS services, groups logs into two levels:
- Log Groups: correspond to a logical service. AWS Lambda create a group log for each function. 
- Log Streams: A single group log can have multiple log streams, which typically correspond to a single running process. Lambda create a log stream for each container instances. If Lambda reuse the container the log will appear in the same stream. 

**Lambda log are not instantaneous it might take few seconds between a function logging a message and the info appearing in CloudWatch.**

Retrieving logs from the command line:
```
sam logs -n HellWorldFunction --stack-name sam-test-1
```
Searching Logs:
```
sam log -n HelloWorldFunction --stack-name sam-test-1 --filter ERROR -s "1 month ago"
```
Continuously check for updates and snow new logs:
```
sam log -n HelloWorldFunction --stack-name same-test-1 --tail
```

## <mark>Simulating Lambda Locally</mark>

Run the following command from your project directory, which contains the `template.yaml`. This should start up a local API Gateway emulation and a local Lambda environment.
```
sam local start-api
```

The simulation will automatically reload the function code if you rebuild the project. 

You can also use `sam local` to send event to individual Lambda functions (even for stacks that do not have an API Gateway) Use `invoke` followed by the name of the function from the stack template. If you do not specify an event, SAM will wait for the event on the console input. You can also pass `--event` followed by a file name containing the test event. 
```
sam local invoke HelloWorldFunction --event event.json
```

**SAM downloads Docker images** -- To save space, SAM does not download the Docker images for Lambda during initial install. The first time you try to execute a function, it will download the image. The init request will take longer then subsequent requests. 

### Debugging functions

You can pass `-d` followed by a port number, and SAM will set up a debug session on the specific port; you can the use stand remote debugging tools. As of 2019 SAM supports this in JavaScript, Python and Go. 
```
sam local invoke HelloWorldFunction --event event.json -d 8080
```
Most IDE tools can connect the that debugging session as well as the Google Chrome DevTools. To open a debugging session in Chrome, open the special `chrome://inspect` page in the browser then add the local machine address and debugging port in the list of available network targets. Chrome will then provide a link to the active debugging session.

### Validating templates 

Instead of waiting for CloudFormation to explode in invalid templates, Use **CDN Lint** to validate locally.
```
# install
pip install cfn-lint`

# check
cfn-lint template.yaml
```

## Setting up a deployment pipeline

The purpose of a pipeline is to reduce errors by making software release reproducible and reliable. A deployment pipeline does that by orchestrating the work required to convert source code into a fully deployed application, automating repetitive and error prone tasks.

A pipeline is closely tied to the workflow of a particular team.

<mark>To fully isolate resources, its best to create septate AWS account for each environment.</mark> Multi-account pipelines are, by design, much more complex then single-account pipelines. 

# 5. Safe Deployments 

In the pervious chapter, we deployed a new version of the example stack. New code was available almost immediately after deployment. This gives the wrong impression that Lambda works similarly to application hosting services such as Heroku. With a new deployment typically upload code to running resources or crease new resources with the upadtes code and then destroys the old resources. <mark>Lambda deployment does not create or destroy resources. It only creates new function configurations</mark>. 

## Function configurations

The core principle of serverless is that the platform is responsible for receiving event from clients NOT YOUR CODE. The network socket (server) belongs to the hosting provider, not your functions. This allows the platform to decided how many instance to run and when. 

The *function configuration* describes all the properties of a runtime environment necessary to spin up a ndew container:
- The runtime type and version (Node, Python, etc)
- How much memory and time the function can use (there are AWS limits)
- The URL of the function code package
- The IAM role 
- Error Recovery, logging and environment parameters of the function.  

You can see the config for any Lambda function using the CLI:
```
aws cloudformation list-stack-resources --stack-name <STACK_NAME>
``` 

## Version and aliases

SAM wired the API gateway to use the `$LATEST` version of the our Lambda function. This is OK for a simple case, but it might be problematic for backwards incompatible deployment in the future. <mark>Update a distributed architecture is not instantaneous. We don't want the API show to get updates first then send a new version of a event ot a older version of the function which does not know how to handle it.</mark>

You can tell Lambda to keep a config version by publishing it. *Published versions* are read-only copies of you function configs, and they are not wiped out after a subsequent update. An event can request that a participle published function version handle a vent. That way, old deployment of the API Gateway can ask for the old Lambda code, and new deployments can ask for the new Lambda functions. 

You do not have to change the alias name for each deployment. SAM will automatically publish an new numerical version and the reassign the existing alias to it. 

AWS current limits 75GB for sorting Lambda functions, including published versions. SM will not auto clean old versions, you may need to do some housekeeping if you deploy large packages frequently. On the other hand, any version that you do not delete will be instantly available in the future.

## Gradual deployments

An alias always point to some numerical version, but it can point to more then one version at hte same time, useful for safe deployments.

Lambda supports automatic load balancing between versions assigned to the same alias, using a feature called *routing configuration*. 

Another AWS product, AWS Code Deploy, can modify the routing config over time to gradually switch aliases between version of code and infra. For example you can use the new version on 10% of traffic and wait for a short period, monitoring for problems, if OK deploy if stop the new code and rollback to older version. 

SAM automates most of the heavy lifting when setting up gradual deployments. 

There are two types of deployment preferences: 
- Linear: incrementally move traffic during a period of time. `Linear10PercentEvery1Minute` - New version start wit only 10% of requests and each mean gets 10%.  
- Canary: Setup request to new version and then deploy to all. `Canary10Percent15Minutes` would send 10% if traffic to the new version if no problems after 15minute move the remaining 90% to new version.

**Adding deployment alerts** - Cloud watch can look out for errors and send nitufaction if metrics exceed some thresholds, using a feature called *alarms*.  

CodeDeploy can also run custom code before and after the deployment, to setup or clean up after tests. This integration uses Lambda functions. Use the `Hooks` property to define a `PreTraffic` and a `PostTraffic` function.

<hr>

# **Part 2 Working with AWS services** 

<hr>

# 6. Handling HTTP requests

So far we have just pass requests from the client browser to a Lambda, but a API Gateway can:
* throttle requests to prevent overloading
* authenticate/authorize requests
* enforce usage plans 
* transform payloads 
* route requests to Lambdas, other web API hosts, or AWS services.  

## API Gateway events 

If a Lambda has an `Api` events associated with it, SAM will create an API Gateway and connect it to the functions. 

In the API Gateway terminology, a *resource* is an endpoint configured to handle an HTTP request on a specific path, and with a specific HTTP method.

## Customizing responses

API Gateway expects responses in a specific form form Lambda Proxy integrations. The response needs to be a JSON object containing: 
* `statusCode` - numeric - a HTTP response code.
* `body` - string - response contents.
* `headers` - string - optional args, and can contain a map of HTTPS response headers. 

SAM assumes that we'll use APU Gateway to create JSON APIs. It assume we'll send a serialized JSON object. Thats why the same function formats the response object with `JSON.stringify`

### Serving static HTML from Lambda is a bad idea

<mark>To keep thing simple we'll use Lambda functions ot send HTML back to the browser. This is fine for quick tutorials. It is MUCH cheaper and faster to host static files in S3 and combine that with Lambda for dynamic responses. Well see this in Chapter 11.</mark>

## Troubleshooting Gateway interactions

API Gateway masks unhandled errors, such as a missing resource, with a `403 Not Authorized` response. This is great for security, but it prevent data leaks, but its a pain for debugging. 

Here are some of the cases you'll see this generic error: 
* If the requests does not reach the Lambda 
* If the function blows up with returning a proper response
* If the function returns a response that's not in the format the API Gateway expects.

The *Resources* screen in the API Gateway Web Console is useful for troubleshooting problems. Click *Test* for a resource in the *Client* box. A diagnostic test screen will open. You can simulate requests and help you find the real problems.

## Using global setting to configure the implicit API

Requests do no go directly from a client to a API Gateway. First they go threw the AWS global content distribution system call CloudFront, which, puts in additional headers like `CloudFront-Viewer-Country`.

SAM can set up two types of API Gateway configs:
* *Edge Optimized* are server from a specific region, but the clients connect to the nearest AWS presence point. For example a API in `us-east-1` (which is North Virginia, USA)m but the user is in Germany, the request will likely connect first oa a CloudFront endpoint in Frankfurt, then the request will pass to the API through the internal AWS links, not the public internet. AWS has fast links between region and improves latency for global user.
* *Regional* APIs do not setup an intermediary connection using CloudFront. If we deploy in `us-east-1`, a user from Germany would connect to the AWS endpoint in North Virginia through the public internet. Global connection would be worst, but local connection would be slightly faster. 

Although CloudFront adds additional cost to each requests, removing it may not actually reduce over all spend. This is because both API Gateway and Cloudfront charge for the number of requests and data transfer, and Cloudfront is slightly cheaper then a API Gateway for data transfers, AWS does not change for transfer between its own services, so the overall combination requests are slightly more but the data transfer are cheaper. 

TLDR: Don't deploy regional endpoints to save money, but do it if you want to remove an intermediary for connection in a specific territory. 

<mark>By default, SAM assume you want edge-optimized APIs.</mark>

## Create parameterized CloudFormation stacks

In the stack template, we confgured event for the `/hello-world` path. But the actual path in the API is slightly different, and it includes the `/Prod/` prefix. Sam Auto create a Prod stage for the implicit api.

In the API Gateway, a *stage* is a published version of the API config. Using sages allows API Gateway to serve a stable version of the API while users are adding or configuring resources to prepare for a new version. 

An API needs at least one stage. The APIs created with SAM will usually have a single stage. 

The standard sage name, `Prod`, forces users to remember mixed cased url, which is more error prone then just lower case. SAM lets you config the same name for an API, but you can't set this in the Global section. 

### Defining stack parameters

*stack parameters* are a way to create customizable stacks. Users can provide their own config when deploy a stack. This make is easy to make reusable stacks.

```
#ch6/template-custom-stage.yaml

AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: >
  Custom stage API demo project 
Globals:
  Function:
    Timeout: 3
  Api:
    EndpointConfiguration: REGIONAL
Parameters:
  AppStage:
    Type: String
    Default: api
    Description: API Gateway stage, used as a prefix for the endpoint URLs
    AllowedPattern: ^[A-Za-z]+$
    MaxLength: 10
    MinLength: 1
    ConstraintDescription: "1-10 Latin letters"
Resources:
  WebApi:
    Type: AWS::Serverless::Api
    Properties:
      StageName: !Ref AppStage
  HelloWorldFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: hello-world/
      Handler: app.lambdaHandler
      Runtime: nodejs12.x
      AutoPublishAlias: live
      Events:
        HelloWorld:
          Type: Api
          Properties:
            Path: /hello
            Method: get
            RestApiId: !Ref WebApi
        SubmitForm:
          Type: Api
          Properties:
            Path: /hello
            Method: post
            RestApiId: !Ref WebApi
Outputs:
  HelloWorldApi:
    Description: "API Gateway endpoint URL"
    Value: !Sub "https://${WebApi}.execute-api.${AWS::Region}.amazonaws.com/${AppStage}/hello/"
```

### `!Ref` or `!Sub`

Because of the `!` this they are function calls. 

The `Sub` substitutes references enclosed with `${}` with related values.

<mark>Use Ref when you need the actual reference, and Sub when you want to combine references with some other text.</mark>

### Providing Parameter values during deployment

```
sam deploy \
    --template-file output.yaml \
    --stack-name same-test-1 \
    --capabilities CAPABILITY_IAM \ 
    -- parameter-override AppStage=api AppName=Demo
```

# 7. Using external storage 

This chapter explains how to connect a Lambda to persistent storage like a file system or a database. 

Lambda instances have a local file system you can write to. Anything stored there is only accessible to that resource and it will be lost once the resource is stopped. 

## Cloud storage options 

There are three main choices fro persistent storage in the cloud: Network file systems, Relational databases, and Key-value stores 

- Network File Systems
    - Generally not a good choice for Lambda. 
    - Attaching an external file system take a significant amount of time.
    - Very few network storage system can cope with potentially 1000s of concurrent users. 

- Relational Databases
    - Good when you need to storage data for flexible queries
    - You page for the flexibility with higher operational costs. 
    - In general you have to plan for capacity and reserve it up front, which is opposite to what the goal is with Lambda.

- Key-Value stores
    - The most frequent choice for persistence of Lambda functions. 
    - Generally optimized for writing and retrieving object by a primary key, not for ad-hoc queries on groups of object.
    - Because data is not interlinked kv stores are less compute demanding then relational dbs. 
    - Their works can be parallelized and scaled more easily.

AWS offer several types of **Key-Value stores** the two main choices are Simple Storage Service (S3) and Dynamo DB. <mark> Both need a init handshake for a connection and they can scale on demand, so Lambda spikes will not overload them and AWS chares actual utilization for them, priced per request. </mark>

- S3
    - object store, designed for large binary unstructured data
    - Object up to 5 TB
    - Object are aggregated into buckets
    - A bucket is like a namespace or a database table
    - if you prefer a file system analogy is like a disk drive
    - Designed for throughput, not predicable (or very low latency)
    - Is useful for extract-transform-load data warehouse scenarios than for ad-hoc or online queries.
    - Pretends to be a web server and let end user devices access object using HTTPS.
    - Supports automatic versioning of objects and can easily revert to pervious state. 
<br><br>
- DynamoDB 
    - A document database / No SQL database
    - Designed for store structured textual data (JSON)
    - Items up to 400KB
    - Stores items in tables, which can either be in a region or globally replicated.
    - Client can write to the same table or ven the same item from many regions at the same time.  
    - Designed for low latency and sustained usage patterns. 
    - Faster then S3 for individual operations.
    - Can scale on demand, but no has quickly as S3.
    - Sudden bursts might be throttled.
    - Accessing data require AWS SDK with IAM auth.
    - Do not provide versioning out of the box. 

<mark> If you want to store huge object and only need to process individual object a time, S3. If you need to store small bits of structured data, with low latency and need to process groups of object in atomic transaction, choose DynamoDB.

| Question                                   | DynamoDB | S3       |     
|--------------------------------------------|:--------:|:--------:| 
| Need low access latency                    | ■        |          |
| Atomic Operations on groups of objects     | ■        |          |
| Append to existing objects                 | ■        |          |
| Query Item contents                        | ■        |          |
| Mostly small items (`<4KB`)?               | ■        |          |
| Items larger then 400KB                    |          | ■        |
| Need versioning and change history         |          | ■        |
| Unpredictable burst traffic patterns       |          | ■        |
| Mostly binary content                      |          | ■        |
| Serve items using HTTPS                    |          | ■        |
| Cheap archiving                            |          | ■        |

## Lambda access rights

AWS does NOT trust a Lambda function to access a DB or S3 just because they belong to the same account. You must allow the use of each resource. To do this wee need modify/create IAM polices associated with the function. 

## Generating unique references 

Each Lambda requests as a unique ID, which is auto printed into the logs. You can read it from the 2nd arg of the Lambda function, using `context.awsRequestId`. 

Using a ref based on the request ID make it unique but aslo easy ro correlate with a processing session. 

If a Lambda retires processing a event after an error, it will use the **same** request ID. If the function dies half-way through working the Lambda spins up another resource to recover from the error, it won't generate two diff files. 

## Using AWS resources form Lambda functions

Lambda function run under temporary access creds, valid only for a few minutes, and they are already setup in the env by the time the function starts. 

When using JavaScript (not other languages), we need to convert the result of a AWS SDK call to a `Promise` objects, to ensure that the Lambda waits for the external cal to finish. 

With Node.js Lambda functions must be `async` or return a `Promise` object. If you forget to convert and SDK into a promise and wait for it to finish, the function will exit too soon and the Lambda will kill the resource before the network call completes. THis does NOT apply to other runtime (but you may need to synchronies with network request differently)

### Passing resource reference to functions

Lambda functions don't know about the SAM and Cloudformation resources. So the function can't just ask for the `UploadS3Bucket` resources.

*Environment Variables* are textual key-value pairs assigned to a running process. They are great for configuring function with references to other repousses in the same SAM template. 

SAM can config env vars for functions using the `Environment` property
```
Environment:
    Variables:
        UPLOAD_S3_BUCKET: !Ref UploadS3Bucket
```

## Authorizing access with IAM polices

Polices are not really signed to a Lambda function. They are assigned to a IAM role, which is associated with the functions. 

Sam automatically create a role for each function, named by appending the world `Role` to the function name. 

## Dealing with network timeouts

by default, Lambda allows a function just three seconds to finish. To up this time use the `Timeout` property in the function Same template. This value is in seconds and the max value in 900 (15 minutes).

To change the default value of `Timeout` for all functions in a template file, modify the `Globals` sections. 

# 8. Cheaper, faster, serverless  

With Lambda, API Gateway and S3, all that infrastructural stuff comes out of the box.

Our example app still looks like a typical 3-tier server setup. In such an architecture an application server
  1. contain the business logic
  2. is a gatekeeper approving or rejecting requests 
  3. is workflow orchestration system talking to backend storage, scheduling asynchronous process  

Out of the 3 only the business logic should stay in Lambda functions. LEts stare by removing hte gatekeeper role from our example app. In Chapter 9 we will look at removing the orchestration role.

Having a Lambda function siting between a user device and S3 is not useful if it only performs authorization. S3 can do that itself. Aws provides several ways of temporarily granting clients the right to do very specific operations:

* Let clients use the AWS SDK directly, and set up IAM users for each client.
  - Using AMI directly, is grate for internal app, and with a small number of named user.
  - The big limit with IAM is that you can only create about 1000 user for an AWS account, and those user can't register directly from your application.
* Setup templated IAM polices for groups of end users auth with AWS cognito (Managed server for user creds)
  - Great for publicly facing applications
  - Store username and passwords securely, optionally allowing user to sign themselves or using federated authentication systems. 
* Use Lambda function to create temp grants for clients, so they can access our AWS resources in a limit way.
  - Great for anonymous access. This method allows you to safely pass on temporary access right with the account creds to the client devices 
  - It does require the create of any kind of user records or up-front restoration 

## Signing requests 

To explain how temp grands work, first we need to explain the roles of AWS security keys.

Each IAM user has two keys: an **access key** and **secret key**. 

When the SDK makes request on t an AWS service it sends the access key in the request header. This allows the service to map the request to an AWS account. 

The SDK also send a cryptographic signature based on the request body and the secret key.

The receiving service uses the access key to locate the corresponding secret key in the IAM database, and also creates a signature for the request. 

If the two signatures match, AWS know that the request was authorized by the user.

The interesting part of this is that some services accept templated signature so we can create a grant up front without knowing all the requesting params. This allow us to effectively product temp grants for user to perform limited opration with our AWS resources.

## Protecting S3 Files

Lets encrypt the file content of upload files to s3 to protect them. In 3-tier server app, and app server could receive the user data and then encrypt it before uploading to S3. With a direct upload, we can't control what is sent to S3, because we've removed the gatekeeper.

We can't do this on the client before setting it because we would need to somehow send our encryption key to the client devices, which is just no ok at all. 

Because encryption is such a common need, AWS implemented ita part of the platform.

You can flip a switch and all newly create files on s3 will be encrypted at rest, regardless of where they come from. With CloudFormation, that switch is the `BucketEncryption` property.

# 9. Handling platform events

This chapter explains how to trigger Lambda functions after platform events such as file uploads to S3. You will also learn the diff between synchronous and asynchronous Lambda invocations. 

The pervious chapter let user upload files, but the app didn't process the upload. To do this we have options

**Create an API endpoint backed by a Lambda that synchronously converts image files into to thumbnails.** It could send the outputs back to the user or save the output to to S3 and redirect the user to the result locations. Simple, but it would not work for large files. API Gateway will stop the requests that take longer then 29 seconds. API Gateway does not allow long-running tasks. 

**Handle the conversion asynchronously.** A typical 3-tier server app the standard way to handle this is to create API endpoints.
1. The first endpoint would start a background task and send the task reference back to the client
2. The second endpoint allows the client to check the status of the task
3. The third allows the client to get outcome of the tasks. 

We can do this via Lambdas, but it can make the app cheaper and faster with serverless designs. We can move some of the orchestration tasks from the app to the platform. 

Instead of a API endpoint we can give the client a pre-signed URL to check the results on S3. With a API endpoint, we'd pay for an API call, a Lambda execution and access to check S3. With the direct S3 approach we only pay for S3 access. 

Similarly, we do not need a separate endpoint to trigger the conversion. Many AWS resources can notify Lambda functions about events. S3 can call a Lambda once a files is upload or deleted. There is no need to pay for the API call and Lambda. 

## <mark>Generating Test Events</mark>

Events coming from S3 will have a diff structure to those coming from API Gateway.

Use `sam local generate-event` to create sample events

S3 upload:
```
sam local generate-event s3 put` 
```

## Working with files 

When we create files in a Lambda resource we need to consider cleaning them up. <mark>Although Lambda functions calls aer independent they are NOT stateless. Lambda can choose to reuses a resource over and over again for the same function. If we never cleanup, the local disk the resource might run out of space. </mark>

## Working with asynchronous events

Lambda supports two types of calls, synchronous and asynchronous:
* Sync Calls -- expect the caller to wait until the Lambda completes. The Lambda reports the result directly to the caller.
* Async Calls -- complete immediately, and the Lambda keeps running in the background. The Lambda can't send the results to the client. S3 and most other platform services use this method.

With Async calls, the function needs to be responsible for storing the output somewhere.

## Avoiding circular references  

SAM sets up Lambda function polices together with the IAM role for the function. To set up the functions, it needs to first setup the role. To setup the role, it would need to know about the target buckers for the permissions.On the other hand, SAM sets up bucket lifecycle event, such as invoking function, together with the bucket. 

So in order o setup the bucket, it would need to know the function reference expecting bucket events. So the upload bucket depends on the conversion function, which depends on the role, which depends on the bucket. Hence the circular dependency. 

To fix this wee need to setup a custom IAM polices and not use SAM templates. SAM can then create the function role, then the conversion function, then the bucket lifestyle events, and then append a policy to an existing role. That way, the function and the role will not depend on the buckets during create. 

### Setting custom IAM polices

CloudFormation has a resource for attaching polices to existing roles, `AWS::IAM::Policy`. We can specify an IAM polices that lets teh roles execute `s3:GetObject` on any resource in the target bucket,  and attach it to the role after both the bucket and the role are create. The policy would depend both on the role adn the bucket, but nothing would depend on the policy it self.

## Handling asynchronous errors with dead letters

With synchronous calls, errors can be reported directly back to the caller, and the caller can then decided to retry or not. With asynchronous calls, the caller can't do that, because its not waiting on results. 

<mark>To project again't infra issues, Lambda will auto retry twice. AWS doesn't state officially state the duration between retires but it seems the first will happen right after a error and the second retry will happen about a minute later.</mark>

If Lambda retires processing an event, it will send the same request ID as in the original attempt. 

If the second retry fails Lambda gives up assuming the issue is with the code. 

Failed events are not necessarily lost fot forever; you can config Lambda to send them a *death letter queue*. You can then set up post failure steps after a failure like, but not limited to, notifying staff of the issue, creating a error report or even a custom retry step.

Lambda can use two types of death letter queues:
* Amazon Simple Queue Service (SQS)
  * Better for offline or batch processing.
  * Sores the message for a listener to retrieve it. If nobody is listening when a message arrives, SQL will keep it in the queue. 
* Amazon Simple Notification Service (SNS)
  * Better choice for instant processing.
  * will ignore message if it has no subscriptions when the message arrives. 

## Conditional resources

CloudFormation can activate or deactivate resources based on conditional, which we need to setup in a separate template sections titled `Conditions`.

```
Conditions:
  ContactEmailSet: !Not [ !Equals [ '', !Ref ContactEmailAddress]]
```

Checks if the `ContactEmailAddress` parameter has a value. 

<hr>

# Part III Designing serverless applications 

<hr>

# 10. Using application components

Lambda runs a reduced version of Amazon Linux, a clone of CentOs, which is a clone of Red Hat Enterprise Linux. ImageMagick tools are usually present on Linux systems; however, they are not included in the more recent Lambda environment.  

## The AWS Serverless Application Repository  

The *AWS Serverless Application Repository* (SAR) is a library of AWS SAM applications. The purposes are to enable orgs to share reusable components internally, so teams can easily deploy infra templates built by other teams and it works a a public library, making a few hundred open-source components available to everyone.

## Lambda layers

A *Lambda layer* is a file package that can be deployed to AWS and then attached to many functions. Layers are useful for sharing large packages across functions and for speeding up deployments. 

From the perspective of a Lambda function, layer is effectively a shared read-only filesystem. Files from a layer appear in the `/opt` directory and we can access them as if they were including the the function. 

A single function can only attach up to 5 layers.

### Linking function with layers

LAyers similarly to functions, get numerical incremental version every time they are published. Unlike Lambda functions, there are NO textual aliases for layer versions, so it's Not possible to mark a current or latest version easily or use a label to differentiate between prod and testing later version. 

This is a serious limitation, and it's logical to expect AWS to provide between solution the future. 

## Publishing to SAR 

SAM just need a bit of metadata about the application added to the template to publish to SAR.

```
Metadata:
  AWS::ServerlessRepo::Application:
    Name: image-thumbnails
    Description: >
      A sample application for the Running Serverless book tutorial
    Author: Gojko Adzic
    SemanticVersion: 1.0.0
    SpdxLicenseId: MIT
    LicenseUrl: LICENSE.md
    ReadmeUrl: README.md 
    Labels: ['layer', 'image', 'lambda', 'imagemagick']
    HomePageUrl: https://runningserverless.com
    SourceCodeUrl: https://runningserverless.com
```
You can use markdown to create a basic markup such as header and links. 

Before we can publish the app to the repo, we need to allow SAR to read template from our deployment bucket. 

# 11. Managing session and user workflows 

This chapter explains how to manage session data n serverless apps and how to reduce ops costs by moving user workflows and app assets out of Lambda functions. 

We used Lambda function to generate HTML code for browsers. There are 3 big problems with this. 

1. There is no feedback from the conversion process to the client. 
2. There is not error handling. 
3. We have two lambdas that share an implicit session state. 

The typical solutions in a tradition web app would be to handle the user session workflow in the middle application layer, but this is creates a lot of problems in server architectures. 

With Lambda, app developers do not control request routing, so sticky sessions are not possible. Requests from the same user might reach two different Lambda instance with different memory session states.

## Moving session state out of Lambda functions 

Session state CANNOT reside in Lambda functions; full stop. 

The usual solution would be to put session state into some kind of distributed data grid. DynamoDB would fits well in this case. Each Lambda could read out the session state the the beginning of the request and save it at the end. BUT this will make each function slower, increase costs and make the app more error prone since function my experience problem update session state and returning to the client. 

In chapter 8, we move the gatekeeper out of the app and onto the platform. As a result, client code can talk directly to AWS using temp access grants. Keeping the workflow on the server side is not improving security anymore. It is safe to move user workflows all the way to the **client devices** and the user session data. <mark> Instead of making the backend stateful, we can keep the user state on the front end.</mark>

### Resumable sessions  

A Big limitation of moving session sate to client devices is the unexpected problem on the frontend can cause user to lose session info. If the browner crashes hal-way though a workflow, the client will not be able to resume the session. 

If you want to create resumable session or let users across multiple browser tabs or devices concurrently, then you'll need to sync session state somehow. 

In a typical three-tier the solution would be keep session in the application server or in a database. 

With serverless there are several ways of synchronizing client session without the app later:
* Amazon Cognito has its own synchronization mechanism for a small amount of user data such as preferences. Its called Cognito Sync.
* For more complex objects, you can give clients direct access to a DynamoDB table, where each user is restricted to reading and writing only their state.
* For situation where different users need to share session state (for example in collaborative editing), us AWS AppSync. AppSync is a managed hierarchial database intended for direct use by client devices, and it can auto sync state across multiple clients, resolve conflicts and even deal with offline usage scenarios. 

### Minimise coordination

With state on the client, we need to minimise the chatter between the client devices and network services, and the amount of coordination between Lambda executions. There are two ways to achieve this: 

* For tightly couple tasks, aggregate processing so that different requests are independent.
* For loosely coupled tasks, send full context info with each requests. 

<mark>Controlling the user session from the client allow us to create a much better user-end experience and reduce costs.The downside is that the client code will need to be MUCH more complex and we will need some way of deploy and managing web assets and client-side code in addition to Lambda code.</mark>

## Moving static assets out of Lambda functions

Traditional web apps bundle code and assets and web servers are responsible for sending both to client devices. Translated to the Lambda world, that would mean including client-side JavaScript and web assets in a Lambda function and creating at least another API endpoint and new function to send those files to clients on demand. 

Serving application static contents such as images, style sheets, client-side JavaScript and HTML files thought a Lambda is a BAD idea. Those files are typically public and do no need auth.

With serverless its better to put static assets somewhere for client to fetch them directly, for example S3. <mark>This is so comment that S3 can pretend to be a web server.</mark>

## Using S3 as a web server

There are two ways of using S3 as a web server:
* Bucket Endpoints
  * Allow direct access to S3 objects usings HTTPS
  * AWS auto activates this endpoint when you create an S3 Bucket.
  * Access to the bucket endpoint is controlled via IAM 
* Website Endpoints
  * Optional feature of s3 that can perform some basic web workflows.
  * This endpoint has a diff URL from the bucket endpoint. 

S3 will auto assign a domain to a website endpoint. Its not possible to set a custom domain, but you can put a CDN between the users and the website endpoint and conf a custom domain name in the CDN. this is the usual approach.

### Working with cross-origin resource sharing

Client code will need to access resource from S3 and API Gateway, which will be on different domains. 

To prevent fraud, browsers request special authorization when a page from one domain want to access resources from another domain. This is cross-origin resources sharing (CORS). 

Here is a quick overview:

An **origin**, in browser terminology, is a combination of URL protocol, domain and, optionally, network port. For example: `https://runningserverless.com`.

Browsers will load resources from a different origin during primary page parsing, but they will not allow background network requests to different origin so easily. 

For example a page from `https://runningserverless.com` will load a image from `gojko.net` without any configuration, however, the same image will not be able to be read asynchronously using JavaScript unless CORS settings allow it. 

Before executing a network request from JavaScript code, browsers will verify that the page is allowed to access a resource on a different origin. To do this a *pre-flight* request is sent to the resource URL. The pre-flight request is an HTTP call using the `OPTIONS` method, including the resource it wants to access and the CORS content URL. <mark>Its essentially a browser asking the remote serve: 'If I were to try making this request for a page from this origin, will you let me?'</mark>

The resource server is supposed to reply to the pre-flight request repeating the requested origin and providing ta list of HTTP header and method it would allow for the resource. Technically, the server respond needs to include the policy in the `Access-Control-Allow-Origin`, `Access-Control-Allow-Method`, and `Access-Control-Allow-Headers` HTTP headers.

The browser compares the headers to the request the Javascript want send. If everything matches the full request is made, otherwise the request will fail. 

When the resource server responds to the full request; it also needs to include the `Access-Control-Allow-Origin` header, without that the browser will refuse to pass the result back to the JavaScript code.

<mark>CORS errors are tricky to troubleshoot, becuase they only apply to background browser actions. Running the same request from a command line won't show any problems. You won't find any logs on the server, because browsers kill request before they they get to our API.</mark> 

When we move web assets to a separate website and move th client workflow to JavaScript, will introduce CORS issues into our example application.

1. "retrieving the web page" is a direct request so it is not affected by CORS
2. "get pre-signed grants" will be a JavaScript call to the API Gateway URL, which will be on a different domain, so it will be restricted by CORS.
3. "upload file" will post a from dynamically to the upload bucket URL, also a different origin and restricted by CORS.
4. "get results" also requires CORS, because we'll be polling the results bucket dynamically to check whether the file is ready. 

<div style="text-align: center;">
  <img style="max-width: 60%;" src="/assets/books/runningServerlessAdzic_ch11LambdaDiagram.svg">
</div>

# 12.Designing robust applications 

## API endpoints with pah parameters 

APU Gateways have a simple solution for case when a port of the request needs to be flexible.Declare an API endpoint using a parameter name in curly braces, and the API Gateway will use it for all matching requests. For example, `/sign/{extension}` and it will handle `/sign/jpg`, `/sign/gif` and any other request with `sign/` in the future. 

To read out the value of the param in a Lambda function. we can use the `pathParameters` field of the API Gateway event. 

Any component of a path can contain a parameter: `/sign/{extension}/image` or multiple `/sign/{extension}/image/{size}`. 
n
We CANNOT create `/sign/{extension}` and `sign/{type}` as the same time; API Gateway would not know who to choose between them. 


### Greedy Path Parameters

**Greedy parameters** matches one or more path components. `/sign/{proxy+}` will match `/sign/jpg` and `/sign/jpg/size/500` this is a useful trick if you want to build your own request routing inside of a lambda function.

<mark>To prevent user errors, we will need to validate extensions using a list of supported types in the Lambda function connected to the API endpoints.</mark>

## Protecting Against abuse

Our example app is completely exposed to the internet. A billion people coming to the app could start a billion requests, and AWS will happily scale, but this is a financial risk.

One of the biggest concerns is how to protect against someone doing a billion requests just o being down a system (DoS attack) or cause financial damage by racking up the AWS bill.

### API throttling 

API Gateway can auto throttle requests, one way of controlling the risk of abuse is to limit the number of requests from the API. 

You can config this for busrt requests per second or steady-sate requests per by using `MethodSettings` Property of the API resource.

### Lambda throttling 

We can limit financial risk from Lambda functions in two ways

1. Restrict the time allowed for execution. Use the `Timeout` setting on the individual functions. You'll need to balance this with giving the function enoughs time to complete expected tasks. 
  * 🗨️ - I am not sure if this is the best option. This might protect again't a stalled method once in a while, but the book uses the example of a user uploading a massive file that takes too long to process. If the process fails nothing is preventing a user from trying ... again ... and again ... and again which might result in more costs. In reality this "large file" example should be solved somehow by putting a limit on the size of 
2. Control the number of concurrent execution for the function. This is effectively throttling requests at the lambda level. By default Lambda limits concurrent executions to 1000 (You can incease this limit by contacting AWS support). Individual Lambda functions can request a much lower limit by using the `ReservedConcurrentExecution` property.


### Monitoring throttling 

We can use CloudWatch alert to notify us about throttling events. 

# 13. Deployment options

## Think about jobs, not functions

Mention Lambdas and function together and people who know functional programing make wrong assumption about AWS Lambda, such as that it is stateless, or that it can parallelize calculations automatically. 

That is why we need to unpick a terminological mess in order to discuss architecture of application base on cloud functions. 

A single Lambda can have a deployment package up to 250MB more than enough for a enterprise app server. There is nothing preventing a big monolithic website and deploying it as a single Lambda function. 

Likewise there is nothing preventing a deployment of a API where each endpoint is handled by a separate Lambda. 

Anything between the two extremes is possible. 

Lambda functions can be just small skeleton initializer which download additional code from a S3 to the temp disk space, because the temp space is shared between executions, this costly init can happen once once per cold start and most requests will not suffer from the additional over head.

Lambda functions are not really stateless or state ful, they are transient. 

Instead of thinking about deploying functions, it is more useful to think about structuring function around discrete jobs which doesn't necessarily perform a single code function. Instead of thinking about stateless or stateful services, its more useful to design for share-nothing architecture, when different parts can own data and share state, but different functions and instances of a single function don't actively share data between themselves.

## One Lambda or many? 

<mark>The common wisdom today seems to be monolithic code is bad and micro-services are boot, but I disagree. Monoliths are usually simpler to develop and manage thant a network service and in many cases faster to deploy. Dividing code and data into multiple machines introduces complexity related to synchronization and consistency, which simply does not exist when everything is in a single memory space. 🗨️ I agree with this!</mark>

Lambda provides many options for breaking down or aggregating processing, and its important to look at the platform constraints so you can pick the best solution in a particular case. 

### Aggregate processing data ownership 

If modifying or accessing data and it needs to ensure conceptual consistency, aggregate it into a single function (and ideally a single request). Data consistency is easier to achieve with a single process then multiple process, even if they run the same code. 

Note the common argument in favor of distributed system over single-instance services is more machines usually have better resilience, but with Lambda this does not app. The platform will handle failover and recovery even if you set the concurrently limit to 1. 

### Aggregate code that needs to be consistent

<mark>A important constraint of the Lambda platform is that different function don't deploy atomically.Its best to design the code assuming thats there will be a shorty period of time where different function may run with different version of app code or that there will be two versions of the same ruction running in parallel. </mark>

<mark>If 2 prices of code need to be fully consistent with each other at all times, put them into the same functions.</mark> 

### Divide code around security boundaries 

Different function can have different security polices, but different parts of the function always run under the same privileges. If you need to reduce or increase the security privileges for some part of a process, it's better to extract that part into a separate Lambda with a separate IAM role. Smaller, more focussed function are less risky from a security perspective.

### Divide code around CPU and Memory needs

Because Lambda chares for memory allocation multiplied by CPU time, bundling task with different memory needs can be unnecessarily expensive. 

When two different usages of the same code have different CPU or memory needs, isolating those usages into two different function van save a lot of money. Think about jobs (uses cases ) when deciding on Lambda granularity not code units. 

### Divide tasks around timing restrictions    

For tasks that take longer then 15 minutes Lambda might not be the correct solutions or you may be able to split a task into several steps and potentially parallelising the work. 

Spitting a job into smaller tasks due to timing restriction typically require an additional process to coordinate the execution of subtasks, and report error or success. Once option for such an umbrella process is to move it to a client devices.

For tasks that cannot be paralleised, consider using AWS Fargate. Its a task management system for Elastic Containers servers with similar billing to Lambda. Fargate tasks start a lot more slowly then Lambda but if the expected duration for a tasks longer then 15 minutes  and few dozen seconds wont matter much.

## Sharing behavior 

There are currently thee options for sharing behavior

* common libraries
* Lambda layers
* Invoking one function form another 

There option differ primarily in four aspects: 
* Latency to execution shared code
* Runtime or deploy-time consistency
* sharing across programming language runtime
* Deployment speed and complexity. 

