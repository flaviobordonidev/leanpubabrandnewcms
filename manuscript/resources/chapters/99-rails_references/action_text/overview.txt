
## Come interagire con Trix di Action Text

* https://blog.craz8.com/articles/2019/9/2/trix-config-object-and-rails-6-webpack

```
var Trix = require("trix")
require("@rails/actiontext")

Trix.config.blockAttributes.heading1.tagName = "h3";
```

In questo modo cambio il comportamento del bottone "TT" che invece di inserire h1 inserisce h3



----

In rails 6 la gemma "trix" è incorporata e diventa Action Text!
Action Text is a brand new framework coming to Rails 6 that’s going to make creating, editing, and displaying rich text content in your applications super easy. It’s an integration between the Trix editor, Active Storage-backed file and image processing, and a text-processing flow that ties it all together. 

installiamo un rich text editor per formattare meglio i nostri posts.
TRIX - Open source gratuito sviluppato da BaseCamp

Installiamo un editor di testo per i nostri campi con Trix
Per i campi "text" invece di usare il **text_area** usiamo la User Interface del text editor "Trix"
questo editor di testo si appoggia ad un field_area che lascieremo nascosto e ci passa del codice html mentre visualizza il risultato formattato nella sua User Interface. In pratica è come se avessimo un piccolo microsoft-word online e quando usiamo il **grassetto** lui visualizza effettivamente il testo in grassetto ma passa nel database i tags html "<bold></bold>" prima e dopo il testo in grassetto. 

Al momento è solo per il testo.
Nel prossimo capitolo installiamo xxx per upload immagini con AWS
Più avanti integreremo la gestione dell'upload delle immagini xxx dentro Trix usando json


Risorse web:

* https://edgeguides.rubyonrails.org/action_text_overview.html

* [BaseCamp Trix](https://github.com/basecamp/trix)
* https://github.com/basecamp/trix#readme
* https://trix-editor.org

* https://gorails.com/episodes/trix-editor?autoplay=1
* (go rails - Trix WYSIWYG Editor And File Uploads)[https://www.youtube.com/watch?v=eyM3_kdD-wY]

* https://www.driftingruby.com/episodes/wysiwyg-editor-with-trix
* (How to use Trix and Shrine for WYSIWYG Editing with Drag-and-Drop Image Uploading)[http://headway.io/blog/how-to-use-trix-and-shrine-for-wysiwyg-editing-with-drag-and-drop-image-uploading/]

---
Altre risorse web:

* [What are the best blogs about Ruby on Rails?](https://www.quora.com/What-are-the-best-blogs-about-Ruby-on-Rails)
* [build-a-blog-with-ruby-on-rails-part-1](https://scotch.io/tutorials/build-a-blog-with-ruby-on-rails-part-1)
* [full-blog-app-tutorial-](https://medium.com/@bruno_boehm/full-blog-app-tutorial-on-rails-zero-to-deploy-4c19e8174791)
* [How To Build A Blog Using Rails 5 - interessante come carica da CDN sia bootstrap (4:50) che font-awesome (5:20)](https://www.youtube.com/watch?v=i2x995hm8r8)
* [il blog non è granché ma ha una gestione della chat online.](https://medium.freecodecamp.org/lets-create-an-intermediate-level-ruby-on-rails-application-d7c6e997c63f)
* [Rails Admin Interfaces with ActiveAdmin - una gemma che ti prepara tutto il dashboard. Resti troppo legato alla loro interfaccia. Modifiche future sono difficili.](https://www.youtube.com/watch?v=NJYtzznKrg0)
* [Let’s Build: With Ruby on Rails – A Blog with Comments - interessante per uso di better-error, guard, ed altro lato develop.](https://web-crunch.com/lets-build-with-ruby-on-rails-blog-with-comments/)
* [Creating a chocolate store using Ruby on Rails - interessante la parte di pagamento con carta di credito](https://www.youtube.com/watch?v=be_EHQnpb8k)
* [Creating an Online Shop in Rails - Part 1](https://www.youtube.com/watch?v=TwoafJC7vlw)
* [Creating an Online Shop in Rails - Part 2]()
* [Creating an Online Shop in Rails - Part 3](https://www.youtube.com/watch?v=q4ciKOT1oHs)
* [Creating an Online Shop in Rails - Part 4](https://www.youtube.com/watch?v=orDmqI-dlCo)
* [Creating an Online Shop in Rails - Part 5](https://www.youtube.com/watch?v=HfV8WP28QFk)
---



## ALTRI WYSIWYG 

Per formattare il testo e fare upload di immagini 




### TRIX - Open source gratuito sviluppato da BaseCamp

* (go rails - Trix WYSIWYG Editor And File Uploads)[https://www.youtube.com/watch?v=eyM3_kdD-wY]
* https://github.com/basecamp/trix
* https://www.driftingruby.com/episodes/wysiwyg-editor-with-trix
* (How to use Trix and Shrine for WYSIWYG Editing with Drag-and-Drop Image Uploading)[http://headway.io/blog/how-to-use-trix-and-shrine-for-wysiwyg-editing-with-drag-and-drop-image-uploading/]




### FROALA - Eccellente WYSIWYG a pagamento una tantum

* https://www.froala.com/wysiwyg-editor/plugins
* (Ruby Snack #22: Froala WYSIWYG)[https://www.youtube.com/watch?v=BrR4dmp2Y8c]
* (Ruby Snack 28: Simple Blog with Froala V2 and Sanitize Gem)[https://www.youtube.com/watch?time_continue=6&v=QVOOBncTe8s]
* (Ruby Snack #23: Froala WYSIWYG Saving Images on Amazon-S3)[https://www.youtube.com/watch?v=WZqztFZpfxQ]
* https://www.froala.com/wysiwyg-editor/docs/framework-plugins/rails




### TinyMCE - Ottimo WYSIWYG a pagamento continuativo

* https://www.tinymce.com
