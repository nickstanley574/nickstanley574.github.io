---
layout: post
emoji: 🦟
asset: "/assets/posts/marcus-login-bug"
---

Over the past few weeks I've been evaluating money management tools. On my list was Goldman Sachs's Marcus. A few years ago I created a Marcus account, but at the time it didn’t fit my needs. Since then things have changed and it was time re-evaluate it.

I attempted to login at  [https://www.marcus.com/us/en/login](https://www.marcus.com/us/en/login) and was redirected to the following page [ https://www.marcus.com/US_Geoblock.html](https://www.marcus.com/US_Geoblock.html) . 

<div style="text-align: center;">
    <img style="max-width: 75%;" src="{{ page.asset }}/marcus-geoblock.png">
</div>

First, I confirm that indeed I was in the United States. Then, I switched from Firefox to Chrome and tired both in incognito mode and the same thing happened. Perhaps Goldman Sachs was having temporary technical difficulties, but the next day the same problem happened again. Next, I wondered if it was my home network, but the same issue happened on my phone’s hotspot.

At this point I called Marcus support and told the agent the information above. Their first question was, “Are you on a VPN or have any VPN software installed?” To which I said "No." <mark>The next question was "Do you have a work computer with a VPN?" I said “yes” and the agent said “Your VPN is interfering with the Marcus on your personal computer.”</mark> Dumbfounded by this revelation that my work computer’s VPN can affect requests made from my personal computer. I asked “Are you sure? My work computer is turned off.” The agent said “Yes, this only happens with VPNs”. 

After a few days I started to think the issue was my account. It had been over a year since the last login and I never opened a financial account. Maybe the Marcus account was marked as inactive and the wrong error page was being displayed. I reset my password and was auto-logged into my account, but was it consistent? I logged-out and attempted logging back in and sure enough, the same geoblock page appeared. You can see this behavior in the video below.

<div style="text-align: center;">
	<video style="max-width: 100%;"  controls>
  	<source src="{{ page.asset }}/MarcusBug.mp4" type="video/mp4">
  	Your browser does not support HTML video.
	</video>
</div>

At this point I am confused, I cannot login from my computer, but I can reset my password and login. Whatever is resulting in the geoblock is used during the login, but not the password reset. The issue is happening on Chrome and on Firefox so whatever the issue is if its my computer somehow causing this its something that is shared between the same between the two browsers. 

<div style="text-align: center;">
    <img style="max-width: 50%" src="/assets/images/one-hour-later.jpeg">
</div>

I found the issue. A browser extension, a very special Selenium IDE. I installed the Selenium IDE on both Chrome and Firefox and have use to help develop tests for my projects. If the Selenium extension is disabled login without issue. This doesn't explain why the geoblock happens at login and not password reset.  

This goes to show software is hard. There are many variables, moving pieces, and interconnected parts its impossible to know how all of them are going to interact. Who know maybe one day a work computer's VPN will affect a personal computer's requests.  