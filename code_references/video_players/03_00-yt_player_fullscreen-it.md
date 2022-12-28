

## Risorse esterne

-[](https://developers.google.com/youtube/android/player/reference/com/google/android/youtube/player/YouTubePlayer.html#setFullscreen(boolean))
-[](https://developers.google.com/youtube/android/player/reference/com/google/android/youtube/player/YouTubePlayer.OnFullscreenListener)
-[](https://stackoverflow.com/questions/30963676/embedded-youtube-player-doesnt-exit-from-full-screen)
-[](https://www.sitepoint.com/community/t/how-do-i-automatically-leave-full-screen-on-youtube-videos/358132/2)



## Fullscreen

Per uscire dal fullscreen: `document.exitFullscreen()`

Per entrare nel fullscreen: `iframe.requestFullscreen();`

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>Fullscreen API demo</title>
  </head>
  <body>
    <iframe
      width="560"
      height="315"
      src="https://www.youtube.com/embed/XHvYhMghk44"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen
    ></iframe>
    <button>Enter Fullscreen</button>

    <script>
      const iframe = document.querySelector('iframe');
      const button = document.querySelector('button');

      button.addEventListener('click', () => {
        iframe.requestFullscreen();

        setTimeout(() => {
          document.exitFullscreen()
        }, 5000)
      });
    </script>
  </body>
</html>
```




```js
    playerVars: {
      autoplay: 1, // Auto-play the video on load
      autohide: 1, // Hide video controls when playing
      disablekb: 1,
      controls: 0, // Hide pause/play buttons in player
      showinfo: 0, // Hide the video title
      modestbranding: 1, // Hide the Youtube Logo
      loop: 1, // Run the video in a loop
      fs: 0, // Hide the full screen button
      rel: 0,
      enablejsapi: 1,
      start: startSeconds,
      end: endSeconds
    },

var playerVars : Dictionary =
["playsinline":"0", // 1 in view or 0 fullscreen
"autoplay":"1", // Auto-play the video on load
"modestbranding":"0", // without button of youtube and giat branding
"rel":"0",
"controls":"0", // Show pause/play buttons in player
"fs":"1", // Hide the full screen button
"origin":"https://www.example.com",
"cc_load_policy":"0", // Hide closed captions
"iv_load_policy":"3", // Hide the Video Annotations
"loop":"0",
"version":"3",
"playlist":"",
"autohide":"0", // Hide video controls when playing
"showinfo":"0"] // show related videos at the end
```
