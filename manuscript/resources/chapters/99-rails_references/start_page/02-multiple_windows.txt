# Finestre multiple

creare un nuovo pannello su global_settings e mettergli il codice in basso:



<div class="list-group left-pad right-pad bottom-pad">

  <!-- http://www.w3schools.com/jsref/met_win_open.asp -->
  <!-- https://developer.mozilla.org/en-US/docs/Web/API/Window/open -->
  <!-- http://stackoverflow.com/questions/6213807/open-a-new-tab-with-javascript-but-stay-on-current-tab -->

  <button onclick="myFunction()">Duplica finestra</button>
  
  <script>
  function myFunction() {
      var myWindow = window.open("#", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=50,left=50,width=400,height=600");
  }
  </script>

</div>