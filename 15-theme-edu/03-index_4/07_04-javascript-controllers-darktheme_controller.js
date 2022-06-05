import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  //var

  modeswitch(){
    let theme = document.documentElement.getAttribute("data-theme"); // get <html> attribute
    let darkpath = document.documentElement.getAttribute("data-darkpath") //get <html> attribute
    let lightpath = document.documentElement.getAttribute("data-lightpath") //get <html> attribute
    //console.log(lightpath)
    let mystyle = document.getElementById("style-switch"); // su <head> è il link a style.css

    if(theme == null || theme === 'light'){
      document.documentElement.setAttribute("data-theme", "dark") // set theme to dark
      mystyle.setAttribute('href', darkpath);
    } else if (theme === 'dark' ) {
      document.documentElement.setAttribute("data-theme", "light") // set theme to dark
      mystyle.setAttribute('href', lightpath);
    }
  }
}
