#Using D3 in iOS#

##Reason##
D3 has a performance hit is because of CPU throttling.
The CPU throttles typically when the CPU has to ‘animate’/bezier paths at least lots of them (GPU cannot used for WebViews would GPU even be performant for it anyway?).

The goal of this is to produce something pretty lightweight.
I am going to be doing this is both UIWebView (pre-iOS8) and with WKWebView for (post-iOS8).

I am going to try to make this project reusable as possible. WKWebView is not well documented, and I believe having a good example (possible Framework in the future) will be beneficial to all.
