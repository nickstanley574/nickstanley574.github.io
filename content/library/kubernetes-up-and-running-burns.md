---
layout: default
build:
  list: false
---

<h1 class="book-title">Kubernetes: Up and Running</h1> 
<h4 class="book-sub ">Brendan Burns, Joe Beda, and Kelsey Hightower</h4>
isbn=9781492046530

# Chapter 1: Introduction

Kubernetes is an open source orchestrator for deploying containerized applications. It was originally developed by Google.

Kubernetes is a reliable infrastructure for distributed systems, catering to cloud-native developers of all sizes, from small Raspberry Pi clusters to large-scale warehouses. It provides essential software for deploying reliable, scalable distributed systems.

There are many reasons why people come to use containers and container APIs like Kubernetes, but we believe they can all be traced back to one of these benefits:

- Velocity
- Scaling (of both software and teams)
- Abstracting
- Efficiency

## Velocity

The difference between you and your competitors is often the speed with which you can develop and deploy new components and features, or the speed with which you can respond to innovations developed by others. Velocity is not defined in terms of speed, user are also interested in a highly reliable service.

Containers and Kubernetes can provide the tools that you need to move quickly, while staying available. The core concepts that enable this are:
- Immutability
- Declarative configuration
- Online self-healing systems

### The Value of Immutability

In an immutable system, rather than a series of incremental updates and changes, an entirely new, complete image is built, where the update simply replaces the entire image with the newer image in a single operation. There are no incremental changes.

### Declarative Configuration

Everything in Kubernetes is a declarative configuration object that represents the desired state of the system. It is the job of Kubernetes to ensure that the actual state of the world matches this desired state.

The combination of declarative state stored in a version control system and the ability of Kubernetes to make reality match this declarative state makes rollback of a change trivially easy. It is simply restating the previous declarative state of the system.

### Self-Healing Systems

Kubernetes continuously works to maintain the desired state configuration, rather than just making a one-time adjustment. It actively monitors and adjusts the system to prevent failures or disturbances that could compromise reliability, ensuring ongoing stability.

## Scaling Your Service and Your Teams

Kubernetes achieves scalability by favoring decoupled architectures.

### Decoupling

In a decoupled architecture, each component is separated from other components by defined APIs and service load balancers. APIs and load balancers isolate each piece of the system from the others.

### Easy Scaling for Applications and Clusters

Because your containers are immutable, and the number of replicas is merely a number in a declarative config, scaling your service upward is simply a matter of changing a number in a configuration file, asserting this new declarative state to Kubernetes, and letting it take care of the rest. Alternatively, you can set up autoscaling and let Kubernetes take care of it for you.

### Scaling Development Teams with Microservices

Kubernetes provides numerous abstractions and APIs that make it easier to build these decoupled microservice architectures:

- **Pods**, or groups of containers, can group together container images developed by different teams into a single deployable unit.
- Kubernetes **services** provide load balancing, naming, and discovery to isolate one microservice from another.
- **Namespaces** provide isolation and access control, so that each microservice can control the degree to which other services interact with it.
- **Ingress** objects provide an easy-to-use frontend that can combine multiple microservices into a single externalized API surface area.

### Separation of Concerns for Consistency and Scaling

The choice between KaaS and self-management depends on skills and needs. Small organizations often prefer KaaS for simplicity, while larger ones with dedicated teams may opt for self-management for more flexibility.

## Abstracting Your Infrastructure

When your developers build applications in terms of container images and deploy them in terms of portable Kubernetes APIs, transferring your app between environments, is a matter of sending the declarative config to a new cluster. Kubernetes has a number of plug-ins that can abstract you from a particular cloud.

## Efficiency

As developers no longer focus on individual machines, their applications can be colocated without affecting them. This allows tasks from multiple users to be tightly packed onto fewer machines, increasing efficiency. Moreover, developers can easily and affordably create test environments by running containers in their personal view of a shared Kubernetes cluster using namespaces.

# Chapter 2: Creating and Running Containers

Traditional methods involve sharing libraries among multiple programs on a single machine, leading to complexity and coupling. Container images, such as Docker or OCI format, package programs and dependencies into a single artifact, simplifying management. Kubernetes supports both Docker and OCI-compatible images, offering flexibility for runtime environments.

## Container Images

A **container image** is a binary package that encapsulates all of the files necessary to run a program inside of an OS container. 

### The Docker Image Format

The Docker image format continues to be the de facto standard, and is made up of a series of filesystem layers. Each layer adds, removes, or modifies files from the preceding layer in the filesystem. This is an example of an overlay filesystem.

### Building Application Images with Docker

A Dockerfile can be used to automate the creation of a Docker container image.

### Multistage Image Builds

Multistage builds in Docker allow for the creation of multiple images from a single Dockerfile. This approach helps to avoid including unnecessary development tools in the final image, resulting in faster deployments.

## The Docker Container Runtime

Kubernetes provides an API for describing an application deployment, but relies on a container runtime to set up an application container using the container-specific APIs native to the target OS. On a Linux system that means configuring cgroups and namespaces. The interface to this container runtime is defined by the Container Run‐ time Interface (CRI) standard.

### Running Containers with Docker

Kubernetes containers are launched by a daemon on each node called the **kubelet**.

### Limiting Resource Usage

Docker provides the ability to limit the amount of resources used by applications by exposing the underlying cgroup technology provided by the Linux kernel. These capabilities are likewise used by Kubernetes to limit the resources used by each Pod.


# Chapter 3: Deploying a Kubernetes Cluster

Local development can be more attractive, and in that case the `minikube` tool provides an easy-to-use way to get a local Kubernetes cluster up running in a VM on your local laptop or desktop. Though this is a nice option, `minikube` only creates a single-node cluster, which doesn’t quite demonstrate all of the aspects of a complete Kubernetes cluster.

We recommend starting with a cloud-based solution unless it's not suitable for your needs. Another option is running a Docker-in-Docker cluster, which can create a multi-node cluster on a single machine. However, this project is still in beta, so unexpected issues may arise.

Appendix A at the end of this book gives instructions for building a cluster from a collection of Raspberry Pi single-board computers. These instructions use the `kubeadm` tool and can be adapted to other machines beyond Raspberry Pis.

## The Kubernetes Client

The official Kubernetes client is kubectl: a command-line tool for interacting with the Kubernetes API. kubectl can be used to manage most Kubernetes objects, such as Pods, ReplicaSets, and Services. kubectl can also be used to explore and verify the overall health of the cluster.

```
# Checking Cluster Status
$ kubectl version


# Simple diagnostic for the cluster
$ kubectl get componentstatuses

NAME                STATUS      MESSAGE             ERROR
scheduler           Healthy     ok
controller-manager  Healthy     ok
etcd-0              Healthy     {"health": "true"}

# Listing Kubernetes Worker Nodes
$ kubectl get nodes

# Get more information about a specific node, such as node-1:
kubectl describe nodes node-1

```

## Cluster Components

### Kubernetes Proxy

The Kubernetes proxy is responsible for routing network traffic to load-balanced services in the Kubernetes cluster. To do its job, the proxy must be present on every node in the cluster.

### Kubernetes DNS

Kubernetes also runs a DNS server, which provides naming and discovery for the services that are defined in the cluster. This DNS server also runs as a replicated service on the cluster.

The DNS service is run as a Kubernetes deployment, which manages these replicas:
```
$ kubectl get deployments --namespace=kube-system core-dns
```

### Kubernetes UI

The final Kubernetes component is a GUI. The UI is run as a single replica, but it is still managed by a Kubernetes deployment for reliability and upgrades.

The final Kubernetes component is a GUI. The UI is run as a single replica, but it is still managed by a Kubernetes deployment for reliability and upgrades. You can see this UI server using:
```
$ kubectl get deployments --namespace=kube-system kubernetes-dashboard
```

The dashboard also has a service that performs load balancing for the dashboard:
```
$ kubectl get services --namespace=kube-system kubernetes-dashboard
```

You can use kubectl proxy to access this UI. Launch the Kubernetes proxy using:
```
$ kubectl proxy
```

This starts up a server running on `localhost:8001` If you visit http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/ in your web browser, you should see the Kubernetes web UI. You can use this interface to explore your cluster, as well as create new containers.

# Chapter 4: Common `kubectl` Commands

## Namespaces

Kubernetes uses **namespaces** to organize objects in the cluster. You can think of each namespace as a folder that holds a set of objects. By default, the `kubectl` commandline tool interacts with the `default` namespace. If you want to use a different namespace, you can pass the `--namespace` flag. If you want to interact with all namespaces—for example, to list all Pods in your cluster— you can pass the `--all-namespaces` flag.

## Contexts

If you want to change the default namespace more permanently, you can use a context. This gets recorded in a kubectl configuration file, usually located at `$HOME/.kube/config`. <mark>This file also stores how to both find and authenticate to your cluster.</mark>

```
# For example, you can create a context with a different default namespace for your kubectl commands using:
$ kubectl config set-context my-context --namespace=mystuff
# To use this newly created context, you can run:
$ kubectl config use-context my-context
```

## Viewing Kubernetes API Objects

Everything contained in Kubernetes is represented by a RESTful resource.

Each Kubernetes object exists at a unique HTTP path; for example, https://your-k8s.com/api/v1/namespaces/default/pods/my-pod leads to the representation of a Pod in the default namespace named my-pod

The most basic command for viewing Kubernetes objects via kubectl is get. If you run `kubectl get <resource-name>` you will get a listing of all resources in the current namespace. If you want to get a specific resource, you can use `kubectl get <resource-name> <obj-name>`.

If you are interested in more detailed information about a particular object, use the describe command:
```
$ kubectl describe <resource-name> <obj-name>
```

## Creating, Updating, and Destroying Kubernetes Objects

Objects in the Kubernetes API are represented as JSON or YAML files. These files are either returned by the server in response to a query or posted to the server as part of an API request. You can use these YAML or JSON files to create, update, or delete objects on the Kubernetes server.

Let’s assume that you have a simple object stored in obj.yaml. You can use kubectl to create this object in Kubernetes by running:
```
$ kubectl apply -f obj.yaml
```

Similarly, after you make changes to the object, you can use the apply command again to update the object:

```
$ kubectl apply -f obj.yaml
```

<mark>The apply tool modifies only differing objects in the cluster. If the objects exist, it exits successfully without changes, making it useful for ensuring cluster and filesystem states match.</mark>

The apply command also records the history of previous configurations in an annotation within the object. You can manipulate these records with the `edit-last-applied`, `set-last-applied`, and `view-last-applied` commands.

For example:
```
$ kubectl apply -f myobj.yaml view-last-applied
```
will show you the last state that was applied to the object.

`kubectl delete -f obj.yaml` - It is important to note that kubectl will not prompt you to confirm the deletion. Once you issue the command, the object will be deleted.

## Debugging Commands

```
# You can use the following to see the logs for a running container:
$ kubectl logs <pod-name>

# You can also use the exec command to execute a command in a running container:
$ kubectl exec -it <pod-name> -- bash

# If you don’t have bash or some other terminal available within your
$ container, you can always attach to the running process:
$ kubectl attach -it <pod-name>

# You can also copy files to and from a container using the cp command:
$ kubectl cp <pod-name>:</path/to/remote/file> </path/to/local/file>

# Display the total CPU and memory in use by the nodes
kubectl top nodes

# Show all Pods and their resource usage. By default it only displays
# Pods in the current namespace, but you can add the --all-namespaces
# flag.
kubectl top pods
```

# Chapter 5: Pods

A **Pod** represents a collection of application containers and volumes running in the same execution environment.

<mark>Pods, NOT containers, are the smallest deployable artifact in a Kubernetes cluster.</mark>

This means all of the containers in a Pod **always** land on the same machine.

Applications running in the same Pod share the same IP address and port space (network namespace), have the same hostname (UTS namespace), and can communicate using native interprocess communication channels over System V IPC or POSIX message queues (IPC namespace).

When designing Pods, ask yourself, "Will these containers function correctly if they're on different machines?" If not, a Pod is the correct grouping. If yes, multiple Pods are likely the correct solution.

## The Pod Manifest

T he simplest way to create a Pod is via the imperative `kubectl` run command. 

```
$ kubectl run kuard --generator=run-pod/v1 --image=gcr.io/kuar-demo/kuard-amd64:blue
```

Kubernetes strongly believes in **declarative configuration**. Pods are described in a Pod manifest. Pod manifests can be written using `YAML` or `JSON`, but `YAML` is preferred because it is more human-editable and has the ability to add comments.

```
# Example 5-1. kuard-pod.yaml

apiVersion: v1
kind: Pod
metadata:
    name: kuard
spec:
    containers:
    - image: gcr.io/kuar-demo/kuard-amd64:blue
      name: kuard
      ports:
    - containerPort: 8080
      name: http
      protocol: TCP
```

Use the kubectl apply command to launch a single instance of kuard:
```
$ kubectl apply -f kuard-pod.yaml
$ kubectl get pods
$ kubectl describe pods kuard
$ kubectl delete pods/kuard
# or kubectl delete -f kuard-pod.yaml
```

When a Pod is deleted, it is not immediately killed. Instead, all Pods have a termination grace period. By default, this is 30 seconds. When a Pod is transitioned to `Terminating` it no longer receives new requests. In a serving scenario, the grace period is important for reliability because it allows the Pod to finish any active requests that it may be in the middle of processing before it is terminated.

## Using Port Forwarding

Later we’ll expose a service to the world or other containers using load balancers—but oftentimes you simply want to access a specific Pod.

To achieve this, you can use the port-forwarding 
```
$ kubectl port-forward kuard 8080:8080
```

A secure tunnel is created from your local machine, through the Kubernetes master, to the instance of the Pod running on one of the worker nodes As long as the port-forward command is still running, you can access the Pod (in this case the kuard web interface) at http://localhost:8080.

## Health Checks

In Kubernetes, containers are kept alive through a process health check, ensuring the main process runs. Yet, this may not suffice. For instance, a deadlocked process won't be detected. To remedy this, Kubernetes introduced liveness health checks. These checks run application-specific logic to ensure proper functionality. As they're application-specific, they must be defined in your Pod manifest.

```
#Example 5-2. kuard-pod-health.yaml

apiVersion: v1
kind: Pod
metadata:
    name: kuard
spec:
    containers:
        - image: gcr.io/kuar-demo/kuard-amd64:blue
        name: kuard
        livenessProbe:
            httpGet:
                path: /healthy
                port: 8080
            initialDelaySeconds: 5
            timeoutSeconds: 1
            periodSeconds: 10
            failureThreshold: 3
        ports:
        - containerPort: 8080
        name: http
        protocol: TCP
```

Of course, liveness isn’t the only kind of health check we want to perform. Kubernetes makes a distinction between liveness and readiness. We will review readiness in Chapter 7.

## Resource Management

Kubernetes allows users to specify two different resource metrics. Resource requests specify the minimum amount of a resource required to run the application. Resource limits specify the maximum amount of a resource that an application can consume.

### Resource Requests: Minimum Required Resources

For example, to request that the kuard container lands on a machine with half a CPU free and gets 128 MB of memory allocated to it, we define the Pod as shown

```
apiVersion: v1
kind: Pod
metadata:
    name: kuard
spec:
    containers:
    - image: gcr.io/kuar-demo/kuard-amd64:blue
    name: kuard
    resources:
        requests:
            cpu: "500m"
            memory: "128Mi"
    ports:
        - containerPort: 8080
        name: http
        protocol: TCP
```

<mark>Resources are requested per container, not per Pod. The total resources requested by the Pod is the sum of all resources requested by all containers in the Pod.</mark>

Requests are used when scheduling Pods to nodes. The Kubernetes scheduler will ensure that the sum of all requests of all Pods on a node does not exceed the capacity of the node. Therefore, a Pod is guaranteed to have at least the requested resources when running on the node. Importantly, “request” specifies a minimum. It does not specify a maximum cap on the resources a Pod may use.

### Capping Resource Usage with Limits

In our previous example we created a kuard Pod that requested a minimum of 0.5 of a core and 128 MB of memory. In the Pod manifest in Example 5-4, we extend this configuration to add a limit of 1.0 CPU and 256 MB of memory.

```
# Example 5-4. kuard-pod-reslim.yaml
apiVersion: v1
kind: Pod
metadata:
  name: kuard
spec:
  containers:
    - image: gcr.io/kuar-demo/kuard-amd64:blue
      name: kuard
      resources:
        requests:
          cpu: "500m"
          memory: "128Mi"
        limits:
          cpu: "1000m"
          memory: "256Mi"
      ports:
        - containerPort: 8080
          name: http
          protocol: TCP
```

## Persisting Data with Volumes

When a Pod is deleted or a container restarts, any and all data in the container’s filesystem is also deleted, but having access to persistent disk storage is an important part of some applications.

To add a volume to a Pod manifest, there are two new stanzas to add to our configuration. The first is a new spec.volumes section.

```
# Example 5-5. kuard-pod-vol.yaml
apiVersion: v1
kind: Pod
metadata:
    name: kuard
spec:
  volumes:
    - name: "kuard-data"
      hostPath:
        path: "/var/lib/kuard"
  containers:
      - image: gcr.io/kuar-demo/kuard-amd64:blue
        name: kuard
   volumeMounts:
      - mountPath: "/data"
        name: "kuard-data"
   ports:
     - containerPort: 8080
       name: http
       protocol: TCP
```

To preserve data integrity across Pod restarts, you can mount a remote network storage volume into your Pod. Kubernetes offers support for various network storage protocols like NFS, iSCSI, and cloud provider-specific APIs.

## Putting It All Together

```
apiVersion: v1
kind: Pod
metadata:
  name: kuard
spec:
  volumes:
    - name: "kuard-data"
    nfs:
      server: my.nfs.server.local
      path: "/exports"
  containers:
    - image: gcr.io/kuar-demo/kuard-amd64:blue
      name: kuard
      ports:
        - containerPort: 8080
          name: http
          protocol: TCP
      resources:
        requests:
          cpu: "500m"
          memory: "128Mi"
        limits:
          cpu: "1000m"
          memory: "256Mi"
      volumeMounts:
        - mountPath: "/data"
          name: "kuard-data"
      livenessProbe:
        httpGet:
           path: /healthy
           port: 8080
        initialDelaySeconds: 5
        timeoutSeconds: 1
        periodSeconds: 10
        failureThreshold: 3
      readinessProbe:
        httpGet:
          path: /ready
          port: 8080
        initialDelaySeconds: 30
        timeoutSeconds: 1
        periodSeconds: 10
        failureThreshold: 3
```

# Chapter 6: Labels and Annotations

## Labels

**Labels** are key/value pairs attached to Kubernetes objects like Pods and ReplicaSets, offering arbitrary identifying information. They're fundamental for grouping objects.
```
$ kubectl get deployments --show-labels
NAME                ... LABELS
alpaca-prod         ... app=alpaca,env=prod,ver=1
alpaca-test         ... app=alpaca,env=test,ver=2
bandicoot-prod      ... app=bandicoot,env=prod,ver=2
bandicoot-staging   ... app=bandicoot,env=staging,ver=2
```

You can also use the `-L` option to `kubectl` get to show a label value as a column:
```
$ kubectl get deployments -L <label_key>
```

If we only wanted to list Pods that had the ver label set to 2, we could use the `--selector` flag:
```
$ kubectl get pods --selector="ver=2"

$ kubectl get pods --selector="app=bandicoot,ver=2"
```

**Selector operators**
| Operator          | Description                        |
|-------------------|------------------------------------|
| key=value         | key is set to value                |
| key!=value        | key is not set to value            |
| key in (value1, value2) | key is one of value1 or value2 |
| key notin (value1, value2) | key is not one of value1 or value2 |
| key               | key is set                         |
| !key              | key is not set                     |


## Annotations

**Annotations** are also key/value pairs but are intended for storing nonidentifying information, serving as a storage mechanism for tools and libraries.

Annotations provide a place to store additional metadata for Kubernetes objects with the sole purpose of assisting tools and libraries. Annotations are used to provide extra information about where an object came from, how to use it, or policy around that object.

# Chapter 7: Service Discovery

Service discovery is essential in Kubernetes for efficiently locating processes and services within the cluster.  Traditional DNS systems are insufficient for Kubernetes, Service objects provide real service discovery capabilities within the cluster.

To understand how service discovery works in Kubernetes, let's create some deployments and services.

```
$ kubectl run alpaca-prod \
--image=gcr.io/kuar-demo/kuard-amd64:blue \
--replicas=3 \
--port=8080 \
--labels="ver=1,app=alpaca,env=prod"

$ kubectl expose deployment alpaca-prod

$ kubectl run bandicoot-prod \
--image=gcr.io/kuar-demo/kuard-amd64:green \
--replicas=2 \
--port=8080 \
--labels="ver=2,app=bandicoot,env=prod"

$ kubectl expose deployment bandicoot-prod

$ kubectl get services -o wide

NAME                CLUSTER-IP      ... PORT(S)     ... SELECTOR
alpaca-prod         10.115.245.13   ... 8080/TCP    ... app=alpaca,env=prod,ver=1
bandicoot-prod      10.115.242.3    ... 8080/TCP    ... app=bandicoot,env=prod,ver=2
kubernetes          10.115.240.1    ... 443/TCP     ... <none>
```

The kubernetes service is automatically created for you so that you can find and talk to the Kubernetes API from within the app.

## Service DNS

Because the cluster IP is virtual, it is stable, and it is appropriate to give it a DNS address. All of the issues around clients caching DNS results no longer apply. Within a namespace, it is as easy as just using the service name to connect to one of the Pods identified by a service.

The full DNS name here is `alpaca-prod.default.svc.cluster.local.`

- `alpaca-prod` - The name of the service in question.
- `default` - The namespace that this service is in.
- `svc` - Recognizing that this is a service. This allows Kubernetes to expose other types of things as DNS in the future.
- `cluster.local.` - The base domain name for the cluster. This is the default and what you will see for most clusters. Administrators may change this to allow unique DNS names across multiple clusters.

## Readiness Checks

One nice thing the Service object does is track which of your Pods are ready via a readiness check.

```
readinessProbe:
  httpGet:
    path: /ready
    port: 8080
  periodSeconds: 2
  initialDelaySeconds: 0
  failureThreshold: 3
  successThreshold: 1
```

This sets up the Pods this deployment will create so that they will be checked for readiness via an HTTP GET to /ready on port 8080. This check is done every 2 seconds starting as soon as the Pod comes up. If three successive checks fail, then the Pod will be considered not ready.

<mark>Only ready Pods are sent traffic.</mark>

## Looking Beyond the Cluster

Pod IPs are often only accessible within the cluster, necessitating the allowance of new inbound traffic. A portable solution for this is employing NodePorts, which augment services. Alongside a cluster IP, NodePorts allocate a port (either system-picked or user-specified), enabling every node in the cluster to forward traffic to that port for the service.

Try this out by modifying the alpaca-prod service:

```
$ kubectl edit service alpaca-prod
```

Change the `spec.type` field to NodePort. You can also do this when creating the service via kubectl expose by specifying `--type=NodePort`. The system will assign a new NodePort:

```
$ kubectl describe service alpaca-prod
```

Here we see that the system assigned port 32711 to this service. Now we can hit any of our cluster nodes on that port to access the service.

If your cluster is in the cloud someplace, you can use SSH tunneling with something like this:

```
$ ssh <node> -L 8080:localhost:32711
```

Now if you point your browser to http://localhost:8080 you will be connected to that service. Each request that you send to the service will be randomly directed to one of the Pods that implements the service. Reload the page a few times and you will see that you are randomly assigned to different Pods.


## Advanced Details

### Endpoints

For applications and the system to utilize services without relying on a cluster IP, Kubernetes introduces Endpoints objects. For each Service object, Kubernetes generates a corresponding Endpoints object containing the IP addresses associated with that service.

Advanced applications can interact directly with the Kubernetes API to access endpoints and make calls. The Kubernetes API supports object watching, allowing clients to promptly respond to changes in objects such as IP addresses associated with a service.

While the Endpoints object is ideal for newly developed code designed for Kubernetes, existing systems typically operate with static IP addresses, making them less reliant on dynamic changes.

### Manual Service Discovery

Kubernetes services use label selectors to identify Pods, enabling basic service discovery through the Kubernetes API without a Service object. However, managing accurate label sets can be complex, leading to the creation of the Service object to address this challenge.

### Cluster IP Environment Variables

While most users should be using the DNS services to find cluster IPs, there are some older mechanisms that may still be in use. One of these is injecting a set of environment variables into Pods as they start up.

| Key                                 | Value                       |
|-------------------------------------|-----------------------------|
| ALPACA_PROD_PORT                    | tcp://10.115.245.13:8080    |
| ALPACA_PROD_PORT_8080_TCP           | tcp://10.115.245.13:8080    |
| ALPACA_PROD_PORT_8080_TCP_ADDR      | 10.115.245.13               |
| ALPACA_PROD_PORT_8080_TCP_PORT      | 8080                        |
| ALPACA_PROD_PORT_8080_TCP_PROTO     | tcp                         |
| ALPACA_PROD_SERVICE_HOST            | 10.115.245.13               |
| ALPACA_PROD_SERVICE_PORT            | 8080                        |

A problem with the environment variable approach is that it requires resources to be created in a specific order. The services must be created before the Pods that reference them. This can introduce quite a bit of complexity when deploying a set of services that make up a larger application.

## Cleanup

Run the following command to clean up all of the objects created in this chapter:

```
$ kubectl delete services,deployments -l app
```

# CHAPTER 8: HTTP Load Balancing with Ingress

In non-Kubernetes setups, users use "virtual hosting" to host multiple HTTP sites on one IP. A load balancer or reverse proxy manages incoming connections on ports 80 and 443, parsing HTTP requests to direct traffic to the right server. The oad balancer or reverse proxy plays “traffic cop” for decoding and directing incoming connections.

Kubernetes calls its HTTP-based load-balancing system Ingress. Ingress is a Kubernetes-native way to implement the “virtual hosting” pattern we just discussed. The Kubernetes Ingress system works to simplify this by

- standardizing that configuration
- moving it to a standard Kubernetes object
- merging multiple Ingress objects into a single config for the load balancer.

The Ingress controller is a software system exposed outside the cluster using a service of `type: LoadBalancer`. It then proxies requests to “upstream” servers.

## Ingress Spec Versus Ingress Controllers

Ingress is very different from pretty much every other regular resource object in Kubernetes. <mark>There is no “standard” Ingress controller that is built into Kubernetes, so the user must install one of many optional implementations.</mark>

Users can create and modify Ingress objects similar to other objects. However, there's no default code executing to act on these objects. It's the responsibility of users (or their distribution) to install and manage an external controller.

### Installing Contour

Here, we use Contour as our Ingress controller. Contour configures Envoy, an open-source load balancer, which is designed for dynamic configuration via an API. The Contour Ingress controller translates Ingress objects into a format that Envoy can interpret.

```
$ kubectl apply -f https://j.hept.io/contour-deployment-rbac
```

This one line works for most configurations. It creates a namespace called heptio-contour.

After you install it, you can fetch the external address of Contour via:
```
$ kubectl get -n heptio-contour service contour -o wide
```

Look at the EXTERNAL-IP column. This can be either an IP address (for GCP and Azure) or a hostname (for AWS). Other clouds and environments may differ.

If you are using minikube, you probably won’t have anything listed for EXTERNAL-IP. To fix this, you need to open a separate terminal window and run minikube tunnel.

#### Configuring DNS

To enable Ingress, set up DNS entries to your load balancer's external address. You can map multiple hostnames to one endpoint, and the Ingress controller will route requests accordingly. For example.com, configure alpaca.example.com and bandicoot.example.com DNS entries. Use A records for IP addresses and CNAME records for hostnames.

#### Configuring a Local hosts File

If you don’t have a domain or if you are using a local solution such as minikube, you can set up a local configuration by editing your /etc/hosts file to add an IP address.

```
<ip-address> alpaca.example.com bandicoot.example.com
```

### Using Ingress

#### Simplest Usage

The simplest way to use Ingress is to have it just blindly pass everything that it sees through to an upstream service.

```
# Example 8-1. simple-ingress.yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: simple-ingress
spec:
  backend:
    serviceName: alpaca
    servicePort: 8080
```

```
$ kubectl apply -f simple-ingress.yaml

$ kubectl get ingress
NAME            HOSTS   ADDRESS PORTS  AGE
simple-ingress  *               80     13m

$ kubectl describe ingress simple-ingress
Name:           simple-ingress
Namespace:      default
Address:
Default backend: be-default:8080
(172.17.0.6:8080,172.17.0.7:8080,172.17.0.8:8080)
Rules:
Host Path Backends
---- ---- --------
*    *    be-default:8080 (172.17.0.6:8080,172.17.0.7:8080,172.17.0.8:8080)
Annotations:
...

Events: <none>
```

This configuration forwards any HTTP request hitting the Ingress controller to the alpaca service. Now, you can access the alpaca instance of kuard using any of the raw IPs/CNAMEs associated with the service, such as alpaca.example.com or bandicoot.example.com.

However, at this stage, it doesn't provide much additional value beyond a simple service of type LoadBalancer. We'll explore more complex configurations in the following sections.

#### Using Hostnames

The common example is having the Ingress system examine the HTTP host header, which matches the DNS domain in the original URL, to route traffic accordingly.

```
# Example 8-2. host-ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: host-ingress
spec:
  rules:
  - host: alpaca.example.com
    http:
      paths:
      - backend:
          serviceName: alpaca
          servicePort: 8080
```

```
$ kubectl apply -f host-ingress.yaml

We can verify that things are set up correctly as follows:
$ kubectl get ingress
NAME            HOSTS               ADDRESS   PORTS   AGE
host-ingress    alpaca.example.com            80      54s
simple-ingress  *                             80      13m

$ kubectl describe ingress host-ingress
Name:         host-ingress
Namespace:    default
Address:
Default backend: default-http-backend:80 (<none>)
Rules:
  Host              Path  Backends
  ----              ----  --------
alpaca.example.com  /     alpaca:8080 (<none>)
Annotations:
  ...
Events:<none>
```

You should now be able to address the alpaca service via http://alpaca.example.com.

#### Using Paths

Another scenario is routing traffic based the path in the HTTP request.

```
Example 8-3. path-ingress.yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: path-ingress
spec:
  rules:
  - host: bandicoot.example.com
    http:
      paths:
      - path: "/"
        backend:
          serviceName: bandicoot
          servicePort: 8080
      - path: "/a/"
        backend:
          serviceName: alpac
```

When there are multiple paths listed for the same host in the Ingress system, the longest prefix match applies. In this example, traffic starting with `/a/` goes to the alpaca service, while other traffic goes to the bandicoot service.


## Advanced Ingress Topics and Gotchas

### Running Multiple Ingress Controllers

To manage multiple Ingress controllers on a cluster, use the `kubernetes.io/ingress.class` annotation to specify which controller should handle each Ingress object. Controllers should be configured with matching strings and process only the relevant annotations. Without this annotation, behavior is undefined, potentially leading to conflicts between controllers.

### Multiple Ingress Objects

When you specify multiple Ingress objects, Ingress controllers should read and merge them into a coherent configuration. However, if there are duplicate or conflicting configurations, the behavior is undefined.

### Ingress and Namespaces

Ingress interacts with namespaces in some nonobvious ways.

Ingress objects are limited to referencing services within the same namespace. Although multiple Ingress objects across namespaces can specify subpaths for the same host, they require global coordination within the cluster. Lack of careful coordination can lead to issues or undefined behavior. Generally, Ingress controllers do not restrict namespaces from specifying hostnames and paths, but advanced users can enforce policies using custom admission controllers.

### Path Rewriting

Some Ingress controllers support path rewriting, altering the path in HTTP requests. This is typically set via an annotation on the Ingress object. For example, NGINX Ingress uses `nginx.ingress.kubernetes.io/rewrite-target: /`, allowing upstream services to function on a subpath. However, path rewriting can introduce bugs as web apps often assume absolute paths. For complex applications, it's best to minimize subpath usage.

### Serving TLS

Users need to specify a secret with their TLS certificate and keys

```
# Example 8-4. tls-secret.yaml
apiVersion: v1
kind: Secret
metadata:
  creationTimestamp: null
  name: tls-secret-name
type: kubernetes.io/tls
data:
  tls.crt: <base64 encoded certificate>
  tls.key: <base64 encoded private key>
```

You can also create a secret imperatively with `kubectl create secret tls <secret-name> --cert <certificate-pem-file> -- key <private-key-pem-file>`.

If multiple Ingress objects specify certificates for the same hostname, the behavior is undefined.

```
# Example 8-5. tls-ingress.yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: tls-ingress
spec:
  tls:
  - hosts:
    - alpaca.example.com
    secretName: tls-secret-name
  rules:
  - host: alpaca.example.com
    http:
      paths:
      - backend:
      serviceName: alpaca
      servicePort: 8080
```



# CHAPTER 9: ReplicaSets

Pods are typically one-off singletons, but in many cases, you'll want multiple replicas of a container running simultaneously. Several reasons drive this replication:

1. Redundancy: Multiple instances allow for fault tolerance.
2. Scale: More instances enable handling a higher volume of requests.
3. Sharding: Different replicas can concurrently handle various parts of a computation.

A ReplicaSet acts as a cluster-wide Pod manager, ensuring that the right types and number of Pods are running at all times. The actual act of managing the replicated Pods is an example of a *reconciliation loop*.

The reconciliation loop is constantly running, observing the current state of the world and taking action to try to make the observed state match the desired state.

## Relating Pods and ReplicaSets

Though ReplicaSets create and manage Pods, they do not own the Pods they create. ReplicaSets use label queries to identify the set of Pods they should be managing. They then use the exact same Pod API that you used directly in Chapter 5 to create the Pods that they are managing.

### Adopting Existing Containers

ReplicaSets are decoupled from the Pods they manage, allowing you to create a ReplicaSet that adopts existing Pods and scales out additional copies of those containers. This seamless transition enables you to move from a single imperative Pod to a replicated set of Pods managed by a ReplicaSet.

### Quarantining Containers

To debug a problematic Pod, update its labels to disconnect it from the ReplicaSet and service. This allows for interactive debugging while the ReplicaSet controller creates a new Pod to replace it. Debugging directly from the Pod is more valuable than relying solely on logs.

## Designing with ReplicaSets

The key characteristic of ReplicaSets is that every Pod that is created by the ReplicaSet controller is homogeneous. The elements created by the ReplicaSet are interchangeable; when a ReplicaSet is scaled down, an arbitrary Pod is selected for deletion. Your application’s behavior shouldn’t change because of such a scale-down operation.

## ReplicaSet Spec

Each ReplicaSet requires a unique name specified in the `metadata.name` field. Additionally, it must include a `spec` section defining the desired number of Pods (replicas) to be running across the cluster at any given time. Lastly, it should contain a Pod template describing the Pod to be created when the specified number of replicas is not met.

```
# Example 9-1. kuard-rs.yaml

apiVersion: extensions/v1beta1
kind: ReplicaSet
metadata:
  name: kuard
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: kuard
        version: "2"
    spec:
      containers:
        - name: kuard
          image: "gcr.io/kuar-demo/kuard-amd64:green"
```

ReplicaSets use Pod labels to monitor cluster state, adjusting the number of Pods to match desired replicas by creating or deleting Pods based on label-filtered results from the Kubernetes API.

## Creating a ReplicaSet

```
$ kubectl apply -f kuard-rs.yaml
```

After accepting the kuard ReplicaSet, the controller detects the absence of matching kuard Pods and creates a new one based on the Pod template.

Example of using describe to obtain the details of the ReplicaSet:

```
$ kubectl describe rs kuard
Name:         kuard
Namespace:    default
Image(s):     kuard:1.9.15
Selector:     app=kuard,version=2
Labels:       app=kuard,version=2
Replicas:     1 current / 1 desired
Pods Status:  1 Running / 0 Waiting / 0 Succeeded / 0 Failed
No volumes.
```

The ReplicaSet controller adds an annotation to every Pod that it creates. The key for the annotation is kubernetes.io/created-by. This will tell you if it was created by a ReplicaSet.

```
$ kubectl get pods <pod-name> -o yaml
```

Finding a Set of Pods for a ReplicaSet. Get the set of labels using the kubectl describe command.

```
$ kubectl get pods -l app=kuard,version=2
```

This is exactly the same query that the ReplicaSet executes to determine the current number of Pods.

## Scaling ReplicaSets

ReplicaSets are scaled up or down by updating the `spec.replicas` key on the ReplicaSet object stored in Kubernetes

The easiest way to achieve this is using the `scale` command in `kubectl`.

```
$ kubectl scale replicasets kuard --replicas=4
```

<mark>While imperative commands are handy for demonstrations and rapid responses to emergencies, it's crucial to update configurations to align with the number of replicas set via the imperative scale command. Any imperative changes should promptly be followed by a declarative update. If the situation isn't urgent, it's recommended to prioritize declarative changes.</mark>

To declaratively scale the kuard ReplicaSet, edit the `kuard-rs.yaml` configuration file and set the `replicas` count to `3`.

```
$ kubectl apply -f kuard-rs.yaml
```

### Autoscaling a ReplicaSet

Kubernetes can handle all of these scenarios via Horizontal Pod Autoscaling (HPA). HPA relies on the heapster Pod in your cluster to monitor metrics and make scaling decisions. Most Kubernetes installations include heapster by default. Verify its presence by listing the Pods in the kube-system namespace. If heapster is missing, autoscaling won't work correctly.

```
$ kubectl get pods --namespace=kube-system
```

You should see a Pod named heapster.

#### Autoscaling based on CPU

Scaling based on CPU usage is the most common use case for Pod autoscaling.

```
$ kubectl autoscale rs kuard --min=2 --max=5 --cpu-percent=80
```

This command creates an autoscaler that scales between two and five replicas with a CPU threshold of 80%. You can use standard kubectl commands to view, modify, or delete this resource using the horizontalpodautoscalers resource. To simplify, you can use the shortened form "hpa":

```
kubectl get hpa
```

## Deleting ReplicaSets

```
$ kubectl delete rs kuard
```

If you don’t want to delete the Pods that are being managed by the ReplicaSet, you can set the `--cascade` flag to false to ensure only the ReplicaSet object is deleted and not the Pods:

```
$ kubectl delete rs kuard --cascade=false
```
# CHAPTER 10: Deployments

Using deployments you can simply and reliably roll out new software versions without downtime or errors.

Like all objects in Kubernetes, a deployment can be represented as a declarative
YAML object that provides the details about what you want to run. In the following
case, the deployment is requesting a single instance of the kuard application:

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: kuard
spec:
  selector:
    matchLabels:
      run: kuard
  replicas: 1
  template:
    metadata:
      labels:
        run: kuard
  spec:
    containers:
    - name: kuard
      image: gcr.io/kuar-demo/kuard-amd64:blue
```

Save this YAML file as kuard-deployment.yaml, then you can create it using:

```
$ kubectl create -f kuard-deployment.yaml
```

As with all relationships in Kubernetes, this relationship is defined by labels and a label selector. You can see the label selector by looking at the Deployment object:

```
$ kubectl get deployments kuard -o jsonpath --template {.spec.selector.matchLabels}

map[run:kuard]
```

You can see that the deployment is managing a ReplicaSet with the label `run=kuard`. We can use this in a label selector query across ReplicaSets to find that specific ReplicaSet:

```
$ kubectl get replicasets --selector=run=kuard

NAME              DESIRED   DESIRED   READY     AGE
kuard-1128242161  1         1         1         13m
```

We can resize the deployment using the imperative scale command:

```
$ kubectl scale deployments kuard --replicas=2

$ kubectl get replicasets --selector=run=kuard

NAME              DESIRED   DESIRED   READY     AGE
kuard-1128242161  2         2         2         13m
```

Try the opposite, scaling the ReplicaSet:

```
$ kubectl scale replicasets kuard-1128242161 --replicas=1

$ kubectl get replicasets --selector=run=kuard

NAME              DESIRED   DESIRED   READY     AGE
kuard-1128242161  2         2         2         13m
```

Scaling the ReplicaSet to one replica doesn't change the desired state set by the Deployment object, which manages the ReplicaSet. As Kubernetes is self-healing, the deployment controller adjusts the replica count back to two to match the desired state. To manage the ReplicaSet directly, delete the deployment with the `--cascade=false` flag to retain the ReplicaSet and Pods.


## Creating Deployments

Prefer declarative management of Kubernetes configurations by maintaining the state of deployments in YAML or JSON files on disk.

The deployment specification closely resembles that of the ReplicaSet. It includes a Pod template, which defines the containers created for each replica managed by the deployment. Additionally, there's a strategy object.

```
...
spec:
  progressDeadlineSeconds: 2147483647
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      run: kuard
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
...
```

The strategy object dictates rollout methods for new software. Deployments support two strategies: Recreate and RollingUpdate, detailed later in this chapter.

## Managing Deployments

```
$ kubectl describe deployments kuard
Name:                   kuard
Namespace:              default
CreationTimestamp:      Tue, 16 Apr 2019 21:43:25 -0700
Labels:                 run=kuard
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               run=kuard
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 ...
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  1 max unavailable, 1 max surg
...
OldReplicaSets:         <none>
NewReplicaSet:          kuard-6d69d9fc5c (2/2 replicas created)
...
```

Crucial output includes `OldReplicaSets` and `NewReplicaSet`, pointing to current and previous ReplicaSets managed by the deployment. Once the rollout is complete, `OldReplicaSets` will be set to `<none>`.

## Updating Deployments

The two most common operations on a deployment are scaling and application updates.

### Scaling a Deployment

Although we showed imperative scaling with kubectl scale, it's best to manage deployments declaratively using YAML files for updates.

```
...
spec:
   replicas: 3
...
```

```
$ kubectl apply -f kuard-deployment.yaml
```
### Updating a Container Image

```
...
containers:
  - image: gcr.io/kuar-demo/kuard-amd64:green
  imagePullPolicy: Always
...
spec:
  ...
  template:
    metadata:
      annotations:
        kubernetes.io/change-cause: "Update to green kuard"
```

Add this annotation to the template, not the deployment itself, as kubectl apply uses this field in the Deployment object. Also, refrain from updating the change-cause annotation during simple scaling operations, as it signifies a significant change triggering a new rollout.


### Rollout History

Kubernetes deployments maintain a history of rollouts.

```
$ kubectl rollout history deployment kuard
deployment.extensions/kuard
REVISION  CHANGE-CAUSE
1         <none>
2         Update to green kuard
```

Add the `--revision` flag to view details about that specific revision:

```
$ kubectl rollout history deployment kuard --revision=2
```

Say there is an issue with the release and you want to roll back:
```
$ kubectl rollout undo deployments kuard
deployment "kuard" rolled back

$ kubectl rollout history deployment kuard
deployment.extensions/kuard
REVISION  CHANGE-CAUSE
1         <none>
3         Update to blue kuard
4         Update to green kuard
```

Revision 2 is missing! Rolling back to a previous revision reuses the template, renumbering it as the latest revision. What was revision 2 is now reordered as revision 4.

By default, the deployment keeps the complete revision history, which can grow large over time. It's recommended to set a maximum history size to limit the total size of the Deployment object, especially for long-term deployments.

Use the `revisionHistoryLimit` property in the deployment specification:

```
...
spec:
# We do daily rollouts, limit the revision history to two weeks of
# releases as we don't expect to roll back beyond that.
revisionHistoryLimit: 14
...
```

## Deployment Strategies

`Recreate` & `RollingUpdate`

The **`Recreate`** updates the ReplicaSet to use the new image and terminates all associated Pods. The ReplicaSet then recreates all Pods with the new image. While fast and simple, <mark>it can cause site downtime. It's best suited for test deployments where some downtime is acceptable.</mark>

**`RollingUpdate`** is the preferred strategy for user-facing services. While slower than Recreate, it's more robust and enables updates without downtime by gradually updating Pods until all are running the new version.<mark> During this time, both old and new versions of your service handle requests. It's vital that each version and its clients can communicate with both older and newer versions.</mark>

The rolling update is highly configurable to suit specific needs. Two parameters allow you to tune its behavior: `maxUnavailable` and `maxSurge`.

The `maxUnavailable` config sets the max number of Pods that can be unavailable during a rolling update, either as an absolute number or a percentage. If it's set to `50%`, the update initially scales down the old ReplicaSet to half its size, immediately replacing it with the new ReplicaSet. This process repeats until the rollout is complete, with service capacity reduced to `50%` at times. This allows us to trade roll‐out speed for availability.

In situations where maintaining 100% capacity is crucial during a rollout, set `maxUnavailable` to `0%`. Instead, manage the rollout with the `maxSurge` parameter, which can be specified as a number or a percentage.

The `maxSurge` value controls amount of extra resource usage during a rollout. For example, if we have `10` replicas and set `maxUnavailable` to `0%` and `maxSurge` to `20%`, the rollout initially scales the new ReplicaSet to `12` replicas, `120%` standard capacity. Then, it scales down the old ReplicaSet, maintaining a maximum of `20%` additional resources used during the rollout.

With `maxSurge` set to `100%`, a blue/green deployment is achieved.

Staged rollouts ensure a healthy service by waiting for each Pod to report readiness before updating the next one. To reliably roll out software using deployments, you must specify readiness health checks for the containers in your Pod. Without these checks, the deployment controller operates blindly.

Sometimes, merely observing a Pod becoming ready doesn't guarantee it's functioning correctly. Certain error conditions may arise after a delay, like a memory leak or rare bugs. Typically, you need to wait for a period to ensure the new version operates correctly before updating the next Pod.

```
...
spec:
  minReadySeconds: 60
...
```

Setting `minReadySeconds` to 60 indicates that the deployment must wait for 60s after seeing a Pod become healthy before moving on to updating the next Pod.

To set the timeout period, the deployment parameter `progressDeadlineSeconds` is used:
```
...
spec:
   progressDeadlineSeconds: 600
...
```

This example sets a progress deadline of 10 minutes. If any stage fails to progress within this time, the deployment is marked as failed, halting further attempts to proceed. Importantly, this timeout measures deployment progress, not its overall duration.


# CHAPTER 11: DaemonSets

For a single Pod per node requirement, use a DaemonSet. For a homogeneous replicated service serving user traffic, a ReplicaSet is the appropriate Kubernetes resource.

`ReplicaSets` are primarily used to ensure that a specified number of identical pods are running simultaneously.

`DaemonSets` ensure that a copy of a pod is running on all (or a subset of) nodes in the Kubernetes cluster. They are typically used for deploying system daemons or background services such as log collectors, monitoring agents, or storage daemons, where one instance per node is necessary.

By default, a DaemonSet will replicate a Pod on every node unless a node selector is applied, restricting eligible nodes based on matching labels. DaemonSets specify the node for Pod creation using the nodeName field in the Pod spec, bypassing the Kubernetes scheduler.

## Limiting DaemonSets to Specific Nodes

<mark>DaemonSets are commonly used to deploy a Pod across every node in a Kubernetes cluster. However, there are scenarios where you may want to deploy a Pod to only a subset of nodes. For instance, if your workload requires a GPU or fast storage available on specific nodes, you can use node labels to tag nodes meeting these requirements.</mark>

Adding Labels to Nodes.
```
$ kubectl label nodes k0-default-pool-35609c18-z7tb ssd=true
```

Node selectors can be used to limit what nodes a Pod can run on in a given Kubernetes cluster. Node selectors are defined as part of the Pod spec when creating a DaemonSet.

<mark>If you remove labels from a node required by a DaemonSet's node selector, the DaemonSet will remove the Pod it manages from that node.</mark>

## Updating a DaemonSet

DaemonSets can be rolled out using the same RollingUpdate strategy that deployments use.

Two parameters control the rolling update of a DaemonSet:
- `spec.minReadySeconds`: Specifies how long a Pod must be "ready" before upgrading subsequent Pods.
- `spec.updateStrategy.rollingUpdate.maxUnavailable`: Indicates the maximum number of Pods updated simultaneously.

A recommended practice is to set `spec.minReadySeconds` to 30–60 seconds to ensure Pod health before proceeding with the rollout.

Delete a DaemonSet

```
$ kubectl delete -f fluentd.yaml
```

When you delete a DaemonSet, it also removes all managed Pods. To delete only the DaemonSet without affecting Pods, use the --cascade=false flag.

# CHAPTER 12: Jobs

While most workloads on a Kubernetes cluster are long-running processes, there's often a need for short-lived, one-off tasks. The Job object is designed specifically for managing such tasks.

## Job Patterns

Jobs are intended for managing batch-like workloads, where work items are processed by one or more Pods. By default, each job runs a single Pod once until successful termination.


| Type        | Use case                                                                | Behavior                                                                           | Completions | Parallelism |
|-------------|-------------------------------------------------------------------------|------------------------------------------------------------------------------------|-------------|-------------|
| One shot    | Database migrations                                                     | A single Pod running once until successful termination                             | 1           | 1           |
|Parallel fixed completions| Multiple Pods processing a set of work in parallel         | One or more Pods running one or more times until reaching a fixed completion count | 1+          | 1+          |
| Work queue: parallel jobs|Multiple Pods processing from a centralized work queue      | One or more Pods running once until successful termination                         | 1           | 2+          |

*See book for specific examples.*

## CronJobs

Sometimes you want to schedule a job to be run at a certain interval. To achieve this you can declare a CronJob in Kubernetes, which is responsible for creating a new Job object at a particular interval.

```
...
spec:
  # Run every fifth hour
  schedule: "0 */5 * * *"
...
```

# CHAPTER 13: ConfigMaps and Secrets

## ConfigMaps

A ConfigMap in Kubernetes acts as a small filesystem or a set of variables for defining environment or command line settings in containers. It's combined with the Pod before execution, enabling reuse of container images and Pod definitions across various applications by changing the associated ConfigMap.

Suppose we have a file on disk (called `my-config.txt`) that we want to make available to the Pod.

```
# Example 13-1. my-config.txt
# This is a sample config file that I might use to configure an application
parameter1 = value1
parameter2 = value2
```

Let’s create a ConfigMap with that file. We’ll also add a couple of simple key/value pairs here.

```
kubectl create configmap my-config \
--from-file=my-config.txt \
--from-literal=extra-param=extra-value \
--from-literal=another-param=another-value
```

Here's the YAML representation of the provided ConfigMap:

```
$ kubectl get configmaps my-config -o yaml

apiVersion: v1
kind: ConfigMap
metadata:
  creationTimestamp: ...
  name: my-config
  namespace: default
  resourceVersion: "13556"
  selfLink: /api/v1/namespaces/default/configmaps/my-config
  uid: 3641c553-f7de-11e6-98c9-06135271a273
data:
  another-param: another-value
  extra-param: extra-value
  my-config.txt: |
    # This is a sample config file that I might use to configure an application
    parameter1 = value1
    parameter2 = value2
```

As you can see, the ConfigMap is really just some key/value pairs stored in an object.


### There are three main ways to use a ConfigMap:

1. Filesystem - You can mount a ConfigMap into a Pod.
2. Environment variable - A ConfigMap can be used to dynamically set the value of an environment variable.
3. Command-line argument - Kubernetes supports dynamically creating the command line for a container based on ConfigMap values.

*See book for specific examples.*

## Secrets

<mark>By default, Kubernetes secrets are stored in plaintext in etcd, which might not suffice for security. Recent Kubernetes versions support encrypting secrets with a user-supplied key, often integrated into a cloud key store. Alternatively, cloud key stores can be integrated with Kubernetes flexible volumes, allowing you to bypass Kubernetes secrets entirely. These options offer flexibility to tailor security profiles to your needs.</mark>

With the `kuard.crt` and `kuard.key` files stored locally, we are ready to create a secret. Create a secret named kuard-tls using the create secret command:

```
$ kubectl create secret generic kuard-tls \
--from-file=kuard.crt \
--from-file=kuard.key

$ kubectl describe secrets kuard-tls
Name:         kuard-tls
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:         Opaque

Data
====
kuard.crt:  1050 bytes
kuard.key:  1679 bytes
```

Instead of accessing secrets through the API server, we can use a **secrets volume**.

Secret volumes in Kubernetes are managed by the kubelet and are created when Pods are initialized. These volumes are stored on tmpfs volumes (also known as RAM disks) and are not written to disk on nodes. Each data element of a secret is stored in a separate file under the target mount point specified in the volume mount.

*See book for specific examples.*

### Private Docker Registries

Image pull secrets automate the distribution of private registry credentials by leveraging the secrets API. Stored like normal secrets, they are consumed via the `spec.imagePullSecrets` field in the Pod specification.

```
kubectl create secret docker-registry my-image-pull-secret \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email-address>
```

### Naming Constraints

Key names for data items inside secrets or ConfigMaps are mapped to valid environment variable names. They can start with a dot followed by a letter or number, and may contain dots, dashes, or underscores. However, dots cannot be repeated, and dots or underscores cannot be adjacent to each other.

## Managing ConfigMaps and Secrets

```
# list all secrets in the current namespace:
$ kubectl get secrets

# list all of the ConfigMaps in a namespace:
$ kubectl get configmaps
```

*See book for specific examples.*

# CHAPTER 14: Role-Based Access Control for Kubernetes

Every request that comes to Kubernetes is associated with some identity. Even a request with no identity is associated with the `system:unauthenticated` group.

Kubernetes makes a distinction between user identities and service account identities.


Kubernetes supports a number of different authentication providers, including:

- HTTP Basic Authentication (largely deprecated)
- x509 client certificates
- Static token files on the host
- Cloud authentication providers
- Authentication webhooks

A **role** is a set of abstract capabilities. For example, the `appdev` role might represent the ability to create Pods and services. A **role binding** is an assignment of a role to one
or more identities. Binding the `appdev` role to the user identity `alice` indicates give the user the ability to create Pods and services.

Kubernetes uses two sets of resources for roles and role bindings. One pair is specific to a namespace (`Role` and `RoleBinding`), while the other pair applies across the entire cluster (`ClusterRole` and `ClusterRoleBinding`).

```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-and-services
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["create", "delete", "get", "list", "patch", "update", "watch"]
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: default
  name: pods-and-services
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: alice
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: mydevs
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: pod-and-services
```

`ClusterRole` and `ClusterRoleBinding` are used for broader permissions across the entire cluster, compared to Role and RoleBinding, which are limited to specific namespaces.

## Verbs for Kubernetes roles

| Verb   | HTTP method | Description                                     |
|--------|-------------|-------------------------------------------------|
| create | POST        | Create a new resource.                          |
| delete | DELETE      | Delete an existing resource.                    |
| get    | GET         | Get a resource.                                 |
| list   | GET         | List a collection of resources.                 |
| patch  | PATCH       | Modify an existing resource via a partial change.|
| update | PUT         | Modify an existing resource via a complete object.|
| watch  | GET         | Watch for streaming updates to a resource.      |
| proxy  | GET         | Connect to resource via a streaming WebSocket proxy.|


## Using built-in roles

Among the built-in roles in Kubernetes, four are aimed at generic end users:

* `cluster-admin`: Grants full access across the entire cluster.
* `admin`: Offers complete access within a specific namespace.
* `edit`: Allows users to modify resources within a namespace.
* `view`: Provides read-only access to resources within a namespace.

## Auto-reconciliation of built-in roles

When the Kubernetes API server starts, it installs default ClusterRoles from its code. Modifying these built-in roles is temporary, as changes get overwritten on server restarts (e.g., during upgrades). To preserve modifications, add the `rbac.authorization.kubernetes.io/autoupdate` annotation with a value of `false` to the built-in ClusterRole resource. This prevents the API server from overwriting the modified ClusterRole.

<mark>By default, the Kubernetes API server allows unauthenticated access to its API discovery endpoint, which can be risky in hostile environments like the public internet.</mark> To mitigate this risk, set the `--anonymous-auth=false` flag on your API server to disable anonymous authentication.

## Techniques for Managing RBAC

### Testing Authorization with can-i

`kubectl auth i-can`

The "can-i" tool is great for testing if a user has permission for a specific action. It's handy for validating configurations during cluster setup or for users to check their access when reporting errors or bugs.

`kubectl auth can-i create pods` will indicate if the current kubectl user is authorized to create Pods.

### Managing RBAC in Source Control

The `kubectl` tool has a `reconcile` command, which aligns roles and role bindings specified in a configuration file with the current cluster state.

`$ kubectl auth reconcile -f some-rbac-config.yaml`

You can add the `--dry-run` flag to the command to print but not submit the changes.

## Advanced Topics

### Aggregating ClusterRoles

<mark>Kubernetes RBAC enables combining multiple roles into a new role using aggregation rules. This new role inherits all capabilities from its subroles, and any changes to them are automatically applied to the aggregate role.</mark>

### Using Groups for Bindings

For managing access to the cluster for many individuals across different organizations with similar permissions, it's best practice to use groups to manage roles instead of individually assigning bindings to each identity.

Group systems often support "just in time" (JIT) access, temporarily adding individuals in response to events like a middle-of-the-night page. This allows auditing access and prevents compromised identities from having continuous access to production infrastructure.

To bind a group to a ClusterRole you use a Group kind for the subject in the binding:

```
...
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: my-great-groups-name
...
```

# CHAPTER 15: Integrating Storage Solutions and Kubernetes

The shift to containerized architectures also signifies a move towards decoupled, immutable, and declarative application development. While these patterns are straightforward to implement for stateless web applications, even "cloud-native" storage solutions such as Cassandra or MongoDB often require manual or imperative steps to establish a reliable, replicated solution.

## Importing External Services

Imagine that we have test and production namespaces defined.The test service is imported using an object like:

```
kind: Service
metadata:
  name: my-database
  # note 'test' namespace here
  namespace: test
```
The production service looks the same, except it uses a different namespace:

```
kind: Service
metadata:
  name: my-database
  # note 'prod' namespace here
  namespace: prod
...
```

In different namespaces, querying the service named "my-database" directs Pods to different databases: "my-database.test.svc.cluster.internal" for the "test" namespace and "my-database.prod.svc.cluster.internal" for the "prod" namespace.


### Services Without Selectors

With services, label queries can be used for identifying sets of Pods as backends for a service. However, external services operate differently. Instead of a label query, there's typically a DNS name pointing directly to the specific server, such as "database.company.com." To incorporate this external database service into Kubernetes, we create a service without a Pod selector that references the DNS name of the database server.

```
# Example 15-1. dns-service.yaml

kind: Service
apiVersion: v1
metadata:
  name: external-database
spec:
  type: ExternalName
  externalName: database.company.com
```

When a standard Kubernetes service is created, it generates an IP address and adds an `A` record to the Kubernetes DNS service. In contrast, creating a service of type ExternalName adds a `CNAME` record pointing to the specified external name (e.g., database.company.com). So, when an application in the cluster looks up "external-database.svc.default.cluster," it resolves to "database.company.com" through DNS aliasing.

Sometimes, you only have an IP address for an external database service, without a DNS address.

First, you create a `Service` without a label selector, but also without the `ExternalName` type we used before

```
# Example 15-2. external-ip-service.yaml

kind: Service
apiVersion: v1
metadata:
  name: external-ip-database
```

Kubernetes assigns a virtual IP address and creates an `A` record for the service. However, without a selector, no endpoints are populated for the load balancer to redirect traffic to.

```
# Example 15-3. external-ip-endpoints.yaml

kind: Endpoints
apiVersion: v1
metadata:
  name: external-ip-database
subsets:
  - addresses:
    - ip: 192.168.0.1
  ports:
  - port: 3306
```

If redundancy is needed with multiple IP addresses, you can repeat them in the addresses array. Once endpoints are populated, the load balancer will redirect traffic from your Kubernetes service to the IP address endpoint(s). Because the user assumes responsibility for keeping the IP address of the server up to date, it's necessary to either ensure that it doesn't changes or to implement an automated process for updating the Endpoints record.

External services in Kubernetes do not conduct health checks. Users must ensure the reliability of the provided endpoint or DNS name for the application.

## Running Reliable Singletons

Instead, deploy a single Pod to run the database or storage solution. This eliminates the challenges associated with replicated storage in Kubernetes, as there is no replication needed. For smaller-scale applications, accepting limited downtime as a trade-off for reduced complexity may be reasonable, although it may not be acceptable for large-scale or mission-critical systems.

*See book example of Running a MySQL Singleton*

## Dynamic Volume Provisioning

Clusters employ **dynamic volume provisioning**, where operators establish StorageClass objects. These classes can be referenced in persistent volume claims instead of specific volumes. When a dynamic provisioner detects this claim, it uses the relevant volume driver to generate and bind the volume.

```
# Example 15-8. storageclass.yaml

apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: default
  annotations:
    storageclass.beta.kubernetes.io/is-default-class: "true"
  labels:
     kubernetes.io/cluster-service: "true"
provisioner: kubernetes.io/azure-disk
```
<mark>Automatic provisioning of persistent volumes in Kubernetes simplifies managing stateful applications. By default, the volume's lifespan aligns with that of the Pod creating it. Thus, deleting the Pod also deletes the volume, which may lead to accidental deletions if not managed carefully.</mark>

Persistent volumes are suitable for traditional applications needing storage. However, for high-availability, scalable storage in a Kubernetes-native manner, StatefulSet objects are preferred.

## Kubernetes-Native Storage with StatefulSets

Initially, Kubernetes focused on homogeneity in replicated sets, lacking individual identities. This posed challenges for stateful application development. To address this, Kubernetes introduced `StatefulSets` in version 1.5, following community feedback.

### Properties of StatefulSets

StatefulSets are replicated Pod groups, akin to ReplicaSets. However, they possess distinct properties:

- Each replica gets a persistent hostname with a unique index (e.g., database-0, database-1, etc.).

- Replicas in a StatefulSet are created sequentially, from the lowest to the highest index. Creation will pause until the Pod at the previous index is healthy and available. This sequencing also applies when scaling up.

- When deleting a StatefulSet, each managed replica Pod is also deleted sequentially, from the highest to the lowest index. Similarly, scaling down the number of replicas follows the same order.

*See book example of Running MongoDB with StatefulSets*

After setting up a StatefulSet, create a "headless" service to manage DNS entries. In Kubernetes, a service is "headless" if it lacks a cluster virtual IP address. Since each Pod in a StatefulSet has a unique identity, load balancing is unnecessary. Specify `clusterIP: None` in the service specification to create a headless service.

## One Final Thing: Readiness Probes

To finalize our MongoDB cluster setup for production, we add liveness checks to the containers serving MongoDB. These checks ensure container functionality. We employ the mongo tool by adding the following to the Pod template in the StatefulSet object:

```
...
livenessProbe:
exec:
  command:
    - /usr/bin/mongo
    - --eval
    - db.serverStatus()
  initialDelaySeconds: 10
  timeoutSeconds: 10
...
```

# CHAPTER 16: Extending Kubernetes

In general, extensions to the Kubernetes API server either enhance cluster functionality or refine user interaction with their clusters.

*See book for this sections*

## Patterns for Custom Resources

### Just Data

The simplest pattern for API extension is the concept of "just data," where the API server is used solely for storing and retrieving information for applications. However, it's important not to use the Kubernetes API server for application data storage. Instead, API extensions should consist of control or configuration objects to manage application deployment or runtime. An example of this pattern is configuring canary deployments, such as directing 10% of traffic to an experimental backend. While such information could be stored in a ConfigMap, using a more strongly typed API extension object often offers clarity and ease of use.

### Compilers

A more advanced pattern is the "compiler" or "abstraction" pattern. Here, the API extension object represents a high-level concept that is translated into lower-level Kubernetes objects. For instance, the LoadTest extension is compiled into Kubernetes Pods and services. Unlike the operator pattern, compiled abstractions do not have online health maintenance; this responsibility falls to the lower-level objects like Pods.

### Operators

Operators provide proactive management of resources, offering higher-level abstractions like databases. They monitor the extension API and the running state of the application, taking actions to ensure health and perform tasks like snapshot backups or upgrades. Operators are the most complex pattern for Kubernetes API extensions, enabling "self-driving" abstractions responsible for deployment, health checking, and repair.

# CHAPTER 17: Deploying Real-World Applications

We’ll take a look at four real-world applications::

- Jupyter, an open source scientific notebook
- Parse, an open source API server for mobile applications
- Ghost, a blogging and content management platform
- Redis, a lightweight, performant key/value store

## Jupyter

Create a namespace:

```
$ kubectl create namespace jupyter
```

Create a deployment of size one with the program itself:

```
#  jupyter.yaml

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  labels:
    run: jupyter
  name: jupyter
  namespace: jupyter
spec:
  replicas: 1
  selector:
    matchLabels:
      run: jupyter
  template:
    metadata:
      labels:
        run: jupyter
    spec:
      containers
      - image: jupyter/scipy-notebook:abdb27a6dfbb
        name: jupyter
      dnsPolicy: ClusterFirst
      restartPolicy: Always
```

```
$ kubectl create -f jupyter.yaml
```

Now you need to wait for the container to be created.
```
$ watch kubectl get pods --namespace jupyter
```

Once the Jupyter running, you the initial login token

```
pod_name=$(kubectl get pods --namespace jupyter --no-headers | awk '{print $1}') \
  kubectl logs --namespace jupyter ${pod_name}
```

Set up port forwarding to the Jupyter container

```
$ kubectl port-forward ${pod_name} 8888:8888
```

Visit `http://localhost:8888/?token=<token>`


*See book for Parse, Ghost, and Redis*

# Chapter 18 Organizing your Application

## Principles to Guide Us

- Filesystems as the source of truth
- Code review to ensure the quality of changes
- Feature flags for staged roll forward and roll back


## Managing Your Application in Source Control

<mark>Combining multiple objects in a single YAML file in Kubernetes is usually discouraged. Only do so if the objects are conceptually identical. Follow design principles akin to defining a class or struct: if the grouping doesn't form a single concept, they shouldn't be in the same file.</mark>

```
frontend/
  frontend-deployment.yaml
  frontend-service.yaml
  frontend-ingress.yaml
service-1/
  service-1-deployment.yaml
  service-1-service.yaml
  service-1-configmap.yaml
...
```

## Structuring Your Application for Development, Testing, and Deployment

*See book for this sections*

## Parameterizing Your Application with Templates

When considering the Cartesian product of environments and stages, it becomes apparent that maintaining them as entirely identical is impractical or impossible.

Different languages for parameterized configurations typically split files into a template file for the main configuration and a parameters file. Most templating languages also allow default parameter values. For instance, Helm, a Kubernetes package manager, offers ways to parameterize configurations.

the Helm template language uses the “mustache” syntax, so for example:

```
metadata:
  name: {{ .Release.Name }}-deployment
```

To pass a parameter for this value you use a `values.yaml` file with contents like:

```
Release:
  Name: my-release
```

Which after parameter substitution results in:

```
metadata:
  name: my-release-deployment
```

Developing dashboards that provide a quick overview of the version running in each region is crucial. Additionally, setting up alerting to trigger when too many different versions of the application are deployed is essential. It's recommended to limit the number of active versions to no more than three: one for testing, one for rolling out, and one for replacement during the rollout process. Having more than three active versions can lead to complications.









































































































































