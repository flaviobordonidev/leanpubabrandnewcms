import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  //var

  connect() {
    //eseguiamo modeswitch appena caricato il codice
    let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    console.log(theme)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
      //localStorage.setItem("data-theme", "dark") // save theme to local storage
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
      //localStorage.setItem("data-theme", "light") // save theme to local storage
    }
  }

  modeswitch(){
    //console.log("CARALHOOO")
    //let theme = localStorage.getItem('data-theme'); // variabile che tiene in memoria se light o dark
    let theme = document.documentElement.getAttribute("data-theme"); // get <html> attribute
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    console.log(lightpath)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
      localStorage.setItem("data-theme", "dark") // save theme to local storage
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
      localStorage.setItem("data-theme", "light") // save theme to local storage
    }
  }

}
