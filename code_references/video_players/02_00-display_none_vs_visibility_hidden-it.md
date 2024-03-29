# <a name="top"></a> Cap video_players 1 - Come nascondere e mostrare il player

La differenza tra `Display: none` e `Visibility: hidden`.


Comando                | Descrizione
| :-                   | :-
`Visibility: hidden;`  | nasconde l'elemento **ma** l'elemento continua a mantenere lo stesso spazio occupato che aveva quando visibile. Quindi l'elemento continua ad influenzare il layout.
`Display: none;`       | The element will be hidden, and the page will be displayed as if the element is not there.



## Risorse interne

- [ubuntudream/17-steps-show_video_with_events/01_00-mockups_youtube_player-it](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/ubuntudream/17-steps-show_video_with_events/01_00-mockups_youtube_player-it.md)



## Risorse esterne

- https://www.w3schools.com/howto/howto_js_toggle_hide_show.asp
- https://www.w3schools.com/css/css_display_visibility.asp
- https://stackoverflow.com/questions/6242976/javascript-hide-show-element



## Display: none Vs Visibility: hidden

Hiding an element can be done by setting the display property to none. The element will be hidden, and the page will be displayed as if the element is not there:

Example

```
h1.hidden {
  display: none;
}
```

visibility: hidden; also hides an element.
However, the element will still take up the same space as before. The element will be hidden, but still affect the layout:

Example

```
h1.hidden {
  visibility: hidden;
}
```

- display	    Specifies how an element should be displayed
- visibility	Specifies whether or not an element should be visible



## Simple example of showing a panel with javascript

Using CSS together with JavaScript to show content
This example demonstrates how to use CSS and JavaScript to show an element on click.

```
<!DOCTYPE html>
<html>
<head>
<style>
#panel, .flip {
  font-size: 16px;
  padding: 10px;
  text-align: center;
  background-color: #4CAF50;
  color: white;
  border: solid 1px #a6d8a8;
  margin: auto;
}

#panel {
  display: none;
}
</style>
</head>
<body>

<p class="flip" onclick="myFunction()">Click to show panel</p>

<div id="panel">
  <p>This panel contains a div element, which is hidden by default (display: none).</p>
  <p>It is styled with CSS and we use JavaScript to show it (display: block).</p>
  <p>How it works: Notice that the p element with class="flip" has an onclick attribute attached to it. When the user clicks on the p element, a function called myFunction() is executed, which changes the style of the div with id="panel" from display:none (hidden) to display:block (visible).</p>
</div>

<script>
function myFunction() {
  document.getElementById("panel").style.display = "block";
}
</script>

</body>
</html>
```



## Example with toggle

```
<!DOCTYPE html>
<html>
<head>
<style>
.imgbox {
  float: left;
  text-align: center;
  width: 120px;
  border: 1px solid gray;
  margin: 4px;
  padding: 6px;
}

button {
  width: 100%;
}
</style>
</head>
<body>

<h3>Difference between display:none and visiblity: hidden</h3>
<p><strong>visibility:hidden</strong> hides the element, but it still takes up space in the layout.</p>
<p><strong>display:none</strong> removes the element from the document. It does not take up any space.</p>

<div class="imgbox" id="imgbox1">Box 1<br>
  <img src="img_5terre.jpg" alt="Italy" style="width:100%">
  <button onclick="removeElement()">Remove</button>
</div>

<div class="imgbox" id="imgbox2">Box 2<br>
  <img src="img_lights.jpg" alt="Lights" style="width:100%">
  <button onclick="changeVisibility()">Hide</button>
</div>

<div class="imgbox">Box 3<br>
  <img src="img_forest.jpg" alt="Forest" style="width:100%">
  <button onclick="resetElement()">Reset All</button>
</div>

<script>
function removeElement() {
  document.getElementById("imgbox1").style.display = "none";
}

function changeVisibility() {
  document.getElementById("imgbox2").style.visibility = "hidden";
}

function resetElement() {
  document.getElementById("imgbox1").style.display = "block";
  document.getElementById("imgbox2").style.visibility = "visible";
}
</script>

</body>
</html>
```



## Example from stackoverflow

How could I hide the 'Edit'-link after I press it? and also can I hide the "lorem ipsum" text when I press edit?

```
<script type="text/javascript">
function showStuff(id) {
  document.getElementById(id).style.display = 'block';
}
</script>


<td class="post">

  <a href="#" onclick="showStuff('answer1'); return false;">Edit</a>
  <span id="answer1" style="display: none;">
    <textarea rows="10" cols="115"></textarea>
  </span>

  Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum 
</td>
```

Answer:

```
function showStuff(id, text, btn) {
    document.getElementById(id).style.display = 'block';
    // hide the lorem ipsum text
    document.getElementById(text).style.display = 'none';
    // hide the link
    btn.style.display = 'none';
}
```

```
<td class="post">

<a href="#" onclick="showStuff('answer1', 'text1', this); return false;">Edit</a>
<span id="answer1" style="display: none;">
<textarea rows="10" cols="115"></textarea>
</span>

<span id="text1">Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum</span>
</td>
```


Why do you add return false in onclick?
I was wondering because it's not needed in case you use # as link.

It may be needed if you don't want to let JavaScript change the url from yourdomain.com/ to yourdomain.com/# 
Furthermore, the scrolling of the window may jump, or any other non considered problem may occur.
