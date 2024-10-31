---
layout: post
excerpt: A casual chat over beers sparks a critical security fix IP whitelisting saves the day by securing AWS Access Keys.
---

A few weeks back, I was discussing security with friends over a few beers. We talked about IP whitelisting to secure environments—like using specific IP access for a jump host or allowing the build server to deploy to particular instances. The conversation moved to AWS, specifically about how scary AWS Access Keys are since they don’t require MFA. Someone mentioned they thought you needed to be on the VPN to allow the usage of the Access Keys, and someone else asked what you have set up to enforce that?

It was at that moment that one of my friends' faces changed because he realized there was nothing preventing the usage of AWS Access Keys off their company’s internal network. We have all experienced those moments in our careers. They asked us how we handle AWS Access Keys and we point them to whitelisting IP Address with IAM permissions. There is a Deny all action policy that you can apply to prevent any request not coming from a set ip range. 

For example, 

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
From: [AWS: Denies access to AWS based on the source IP](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_deny-ip.html )

Later my friend implemented the Deny policy based on Ip Address and it worked and he was  praised for the implementation.  It's funny how some of the best free consulting happens over a few pints of beer.

