---
layout: book
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