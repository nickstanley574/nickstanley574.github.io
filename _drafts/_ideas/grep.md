🔍
I was chatting with someone yesterday and they mentioned that they don’t really understand exactly how the grep works or how to look at it.



For example, pretend you have a Jenkins Job that deploy you could and then after the deploy does a check to make sure the instance is health, but adding it back into the load balancer pool. 

```
Context Line Control
    -A NUM, --after-context=NUM
            Print NUM lines of trailing context after matching lines.  Places a line containing  a  group  separator  (--)  between contiguous  groups  of matches.  With the -o or --only-matching option, this has no effect and a warning is given.

    -B NUM, --before-context=NUM
            Print  NUM  lines  of  leading  context  before  matching  lines.  Places a line containing a group separator (--) between contiguous groups of matches.  With the -o or --only-matching option, this has no effect and a warning is given.

    -C NUM, -NUM, --context=NUM
            Print NUM lines of output context.  Places a line containing a group separator (--) between contiguous groups  of  matches With  the  -o  or --only-matching option, this has no effect and a warning is given.

```