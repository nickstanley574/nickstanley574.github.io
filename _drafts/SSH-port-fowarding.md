---
layout: post
emoji: 🐡
title: SSH Port Forwarding
---

The software discipline has an abundance of tools, options and commands. An individual will never know them all. Even commands someone use everyday can hide a hidden trick they never knew existed. One of my favorite tricks to show people is the ssh `L` option.

I highly recommend reading the ssh -L man pages to understand all the functionality of `L`, but for now lets explore the following command.

```
ssh -N -v 3.22.101.132 -L 7373:localhost:8282
```

The core of the command `-L 7373:localhost:8282` instructs ssh to listen for requests made local `localhost:7373` and forward the request over the secure ssh tunnel to `localhost:8282` on `3.22.101.132`. The `-v` gives verbose output to see the connection details and the `-N` doesn’t open an actual remote shell. The port forwarding would still work with `-v` and `-N` omitted.

Lets see this in action. I set up a remote server running NGINX on port 8282 and the security rules only allow connections from my computer's ipaddress on port 22.

```
$ ssh -N -v 3.22.101.132 -L 7373:localhost:8282
OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
…
…
debug1: Authentication succeeded (publickey).
Authenticated to 3.22.101.132 ([3.22.101.132]:22).
debug1: Local connections to LOCALHOST:7373 forwarded to remote address localhost:8282
debug1: Local forwarding listening on ::1 port 7373.
debug1: channel 0: new [port listener]
debug1: Local forwarding listening on 127.0.0.1 port 7373.
debug1: channel 1: new [port listener]
…
…
```

Great the connection succeeded and the verbose output shows ssh forwarding local `localhost:7373` to `localhost:8282` on `3.22.101.132`. Now lets make a request to `localhost:7373`.

```
$ curl localhost:7373
<!DOCTYPE html>
<html>
<head>
<h1>Welcome to the remote server!</h1>
</body>
</html>

===== $ ssh -N -v 3.22.101.132 -L 7373:localhost:8282 =====
...
debug1: Connection to port 7373 forwarding to localhost port 8282 requested.
debug1: channel 2: new [direct-tcpip]
...

```

The ssh debug1 output confirms ssh is listening on `localhost:7373` and the `curl` request was forwarded to `localhost:8282` on `3.22.101.132`. And it is just that easy, well deceptively easy, the diagram outlines how the request forwarding is begin handled by the `ssh -L` and `sshd`.


<div style="text-align: center;">
    <img style="max-width: 100%;" src="/assets/ssh-port-fowarding/ssh-L-diagram.svg" >
</div>

## Use Cases

### Limit access to non-federated webpage

### Connected to services binded to localhost for debugging

### Keep AWS sec groups simple by only exposing port 22.

