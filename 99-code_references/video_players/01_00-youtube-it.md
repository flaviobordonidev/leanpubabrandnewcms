# <a name="top"></a> Cap video_players 1 - Il player video di Youtube



## Risorse esterne

- https://developers.google.com/youtube/iframe_api_reference
- https://developers.google.com/youtube/player_parameters
- https://developers.google.com/youtube/youtube_player_demo
- https://jsfiddle.net/jeffposnick/WhLH5/1/
- https://blogs.perficient.com/2021/01/07/implementing-custom-play-pause-button-for-embedded-youtube-videos-using-iframe-player-api/
- https://www.makeuseof.com/tag/best-free-online-html-editors/
    1. CodePen (https://codepen.io/)
    2. JSFiddle (https://jsfiddle.net/)
    3. JSBin (http://jsbin.com/)
    4. Liveweave (https://liveweave.com/)
    5. solo HTML
    6. solo HTML
    7. Dabblet (https://dabblet.com/)
- https://developer.mozilla.org/en-US/docs/Web/API/Node/insertBefore
- https://www.javascripttutorial.net/javascript-dom/javascript-insertbefore/

- [Gestire le chiamate javascript](https://forum.matomo.org/t/cutom-html-tag-load-javascript-with-custom-attributes/38546)



## Cutom HTML Tag - load javascript with custom attributes

Hello,
I need to generate a custom html tag that runs a specific javascript, and passes custom attributes to it. Something like:
<script src="https://consent.cookiebot.com/uc.js" data-cbid="some-numbers" data-blockingmode="auto" type="text/javascript"></script>
I use as trigger DOM ready, and this tag needs to be at head start as first, so top priority.

Problem is, the Tag gets fired but no attributes is passed. In my DOM i just get:
<script src="https://consent.cookiebot.com/uc.js" type="text/javascript"></script>
and obviously the javascript fails.

Any tipps why the custom attributes are discarded?

Thanks for the help!

Hi,
You could use a method very similar to the Matomo tracking code: Write a bit of JS that adds the script tag you want to the DOM.

The Matomo tracking code looks like this:

var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
g.type = 'text/javascript';
g.async = true;
g.defer = true;
g.src = u + 'statistics.js';
s.parentNode.insertBefore(g, s);
So you can fit this to your use case like this

const scriptEl = document.createElement('script')
const firstScript = document.getElementsByTagName('script')[0];
scriptEl.type = 'text/javascript';
scriptEl.src = 'https://consent.cookiebot.com/uc.js'
scriptEl.dataset.cbid = "some-numbers"
scriptEl.dataset.blockingmode = "auto"
firstScript.parentNode.insertBefore(scriptEl, firstScript);

or if you need to support older browsers (https://caniuse.com/dataset, https://caniuse.com/const) and are okay with more ugly code

var scriptEl = document.createElement('script')
var firstScript = document.getElementsByTagName('script')[0];
scriptEl.type = 'text/javascript';
scriptEl.src = 'https://consent.cookiebot.com/uc.js'
scriptEl.setAttribute("data-cbit", "some-numbers")
scriptEl.setAttribute("blockingmode", "auto")
firstScript.parentNode.insertBefore(scriptEl, firstScript);

