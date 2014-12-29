#Using D3 in iOS#

##Reason##
D3 has a performance hit is because of CPU throttling.
The CPU throttles typically when the CPU has to ‘animate’/bezier paths at least lots of them (GPU cannot used for WebViews would GPU even be performant for it anyway?).

The goal of this is to produce something pretty lightweight and can serve a bunch of purposes.
I am going to be doing this is both UIWebView (pre-iOS8) and with WKWebView for (post-iOS8).

I am going to try to make this project reusable as possible. WKWebView is not well documented, and I believe having a good example (possible Framework in the future) will be beneficial to all.



##To avoid performance issues##
According to this [article](http://marmelab.com/blog/2013/07/01/building-sophisticated-webapps-for-mobile-a-bumpy-ride.html), the performance his is because of redrawing.
This can be avoided by using HTML rather than SVGs.

##Work used to create this##
* [NSHipster](http://nshipster.com/wkwebkit/)
* [Josh Kehn](https://github.com/joshkehn/JSMessageExample)

##Honorary Mentions##
* [WebViewJavascriptBridge](https://github.com/marcuswestin/WebViewJavascriptBridge) (Supports both WebKit and UIWebView).
* [Neunode](https://github.com/snakajima/neunode), too focused on the 'server' for this project, but would love to play with it.
