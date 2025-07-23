---
layout: post
title: SSH Port Forwarding
---

The software discipline has an abundance of tools, options and commands. An individual will never know them all. Tools used by someone every day can hide a hidden trick they never knew existed. One of my favorite tricks to show people is SSH port forwarding using the `L` and `R` options. They are not hard to use or understand and once added to your toolbox, open a whole new world of advantages.

### Local Port Forwarding `-L`

Local port forwarding sends requests made to a port on your local machine to a port on a remote machine via the SSH client and SSH server. This might seem complex, seeing it in action should show how simple it is.

```
nick@local:~$ ssh -N -v 3.22.101.132 -L 6363:localhost:8282
```

The core of the command `-L 6363:localhost:8282` instructs the ssh-client to listen for requests made on your machine's `localhost:6363` and forward the requests over the secure ssh tunnel to `localhost:8282` on `3.22.101.132`. The `-v` gives verbose output to see the connection details and the `-N` doesn’t open an actual remote shell. The port forwarding would still work with `-v` and `-N` omitted.

I spun-up a remote server running NGINX on `localhost:8282` and the security rules only allow connections from my machine's IP address on port 22.

```
nick@local:~$ ssh -N -v 3.22.101.132 -L 6363:localhost:8282
OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
...
debug1: Authentication succeeded (publickey).
Authenticated to 3.22.101.132 ([3.22.101.132]:22).
debug1: Local connections to LOCALHOST:6363 forwarded to remote address localhost:8282
debug1: Local forwarding listening on ::1 port 6363.
debug1: channel 0: new [port listener]
debug1: Local forwarding listening on 127.0.0.1 port 6363.
debug1: channel 1: new [port listener]
...
```

The connection succeeded and the output shows SSH forwarding my machine's `localhost:6363` to `localhost:8282` on `3.22.101.132`. Using `curl` to make a request to my machine's `localhost:6363` let's see the response.

```
nick@local:~$ curl localhost:6363
<!DOCTYPE html>
<html>
<head>
<h1>Welcome to 3.22.101.132 a.k.a the remote server!</h1>
</body>
</html>

==> $ ssh -N -v 3.22.101.132 -L 6363:localhost:8282 <==
...
debug1: Connection to port 6363 forwarding to localhost port 8282 requested.
debug1: channel 2: new [direct-tcpip]
...

```

The output confirms the `curl` request was forwarded to `3.22.101.132`'s `localhost:8282`. And it is just that easy, well deceptively easy, the diagram gives a high level of how the request forwarding is being handled by `ssh -L` and `sshd`.


<div style="text-align: center;">
    <img style="max-width: 100%;" src="/assets/posts/ssh-port-fowarding/ssh-L-diagram.svg" >
</div>


### Remote Port Forwarding `-R`

The `-R` option works the same way has `-L`, but in reverse. Instead of forwarding requests from your local machine to the remote server the remote server forwards request to your local machine.

```
nick@local:~$ ssh -N -v 3.22.101.132 -R 7373:localhost:9292
```

This instructs `sshd` on `3.22.101.132` to listen for requests made to `localhost:7373` and forward them to your machine's `localhost:9292`. Time to see this in action round two.

```
nick@local:~$ ssh -N -v 3.22.101.132 -R 7373:localhost:9292
OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
...
debug1: remote forward success for: listen 7373, connect localhost:9292
debug1: All remote forwarding requests processed
...
```

Similar to `-L` the `-R` command output indicates the port forwarding is configured and ready for use. From `3.22.101.132` lets make a request to its `localhost:7373`


```
nick@ip-3-22-101-132:~$ curl localhost:7373
<!DOCTYPE html>
<html>
<head>
<h1>Welcome to Nick's local machine!</h1>
</body>
</html>

==> $ nick@local:~$ -N -v 3.22.101.132 -R 7373:localhost:9292 <==
...
debug1: client_input_channel_open: ctype forwarded-tcpip rchan 2 win 2097152 max 32768
debug1: client_request_forwarded_tcpip: listen localhost port 7373, originator 127.0.0.1 port 37594
debug1: connect_next: host localhost ([127.0.0.1]:9292) in progress, fd=5
debug1: channel 0: new [127.0.0.1]
debug1: confirm forwarded-tcpip
debug1: channel 0: connected to localhost port 9292
...
```

Boom, `3.22.101.132` accessed the `index.html` file served from my local machine's `localhost:9292`.

<div style="text-align: center;">
    <img style="max-width: 100%;" src="/assets/posts/ssh-port-fowarding/ssh-R-diagram.svg" >
</div>

### SSH Port Forwarding out in the Wild

You might be wondering ok this is cool, so what? What can I use this for in the real world? Below is a list of cases either I or a colleague I know has used SSH port forwarding.

* Keep security group simple by only allowing connections over port 22.
* Limit access to a non-federated webpage with sensitive materials.
* Connect to a remote database bound to localhost and use a local GUI interface.
* Test an application by forwarding the local instance of an webapp to a development load balancer.
* Limit access to an API endpoint.
* Connect to servers via a Bastion/Jump host.
* Temporarily encrypt traffic on a legacy application while setting up TLS.
* Get around firewall rules by forwarding requests through your local machine that doesn't have the same restrictions. Tread carefully with this one.
