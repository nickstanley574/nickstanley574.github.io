---
title: "Whitelisting AWS Access Keys"
date: 2021-07-12
---

A few weeks back, I was discussing security with former classmates over a few beers.

We started talking about IP whitelisting to secure environments things like:

- Allowing access to a jump host from specific IP addresses
- Restricting a build server so it can only deploy to certain instances

The conversation drifted to AWS, and specifically to how **scary AWS Access Keys can be**. Unlike the AWS Management Console, Access Keys don’t require MFA.

Someone in the group mentioned they thought you needed to be on the company VPN to use Access Keys. Another asked: “What do you have set up to enforce that?”

He suddenly realized there was nothing stopping AWS Access Keys from being used outside his company’s internal network.

We’ve all had those moments in our careers when a security gap becomes glaringly obvious. In this case, the fix was straightforward: whitelist IP addresses in IAM policies.

AWS even provides an example of a “Deny all unless from these IPs” policy:
```
{
    "Version": "2012-10-17",
    "Statement": {
        "Effect": "Deny",
        "Action": "*",
        "Resource": "*",
        "Condition": {
            "NotIpAddress": {
                "aws:SourceIp": [
                    "192.0.2.0/24",
                    "203.0.113.0/24"
                ]
            }
        }
    }
}
```
From: [AWS: Denies access to AWS based on the source IP](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_deny-ip.html)

Later, my friend implemented the Deny policy based on IP address. It worked perfectly, and he was praised for tightening security.

Funny how, some of the best security advice comes over a few pints of beer.