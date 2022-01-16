# <a name="TOP"></a> Markdown Cheatsheet

Indentando di 4 spazi (o 1 TAB) diventa codice.

    Indentando di 4 spazi (o 1 TAB) diventa codice.

oppure un blocco tra 3 tilde iniziali e 3 tilde finali.

```
oppure un blocco tra 3 tilde iniziali e 3 tilde finali.
quindi anche su più righe
come in questo caso
^_^
```


Con 4 trattini distanziati ottendo una linea di separazione orizzontale:

- - - -

```
- - - -
```


Lo stesso lo ottengo con 3 trattini tutti attaccati:

---

    ---


---
Vediamo i Titoli e il testo comune.
(I titoli possono anche non avere le "#" in fondo alla linea.)

# Heading 1 #

    # Heading 1 #

## Heading 2 ##

    ## Heading 2 ##

### Heading 3 ###

    ### Heading 3 ###

#### Heading 4 ####

    #### Heading 4 ####

Common text

    Common text

*Emphasized text*

    *Emphasized text* or _Emphasized text_

**Strong text**

    **Strong text** or __Strong text__

***Strong emphasized text***

    ***Strong emphasized text*** or ___Strong emphasized text___

~~Strikethrough text~~

    ~~Strikethrough text~~

~~***Strong emphasized strikethrough text***~~

    ~~***Strong emphasized strikethrough text***~~


---
Vediamo testo messo in "Quote" e liste.

> Blockquote
>> Nested blockquote

```
> Blockquote
>> Nested blockquote
```


* Bullet list
    * Nested bullet
        * Sub-nested bullet etc
* Bullet list item 2

```
* Bullet list
    * Nested bullet
        * Sub-nested bullet etc
* Bullet list item 2

-OR-

- Bullet list
    - Nested bullet
        - Sub-nested bullet etc
- Bullet list item 2 
```


1. A numbered list
    1. A nested numbered list
    2. Which is numbered
2. Which is numbered

```
1. A numbered list
    1. A nested numbered list
    2. Which is numbered
2. Which is numbered
```


- [ ] An uncompleted task
- [x] A completed task

```
- [ ] An uncompleted task
- [x] A completed task
```


- [ ] An uncompleted task
    - [ ] An uncompleted subtask

```
- [ ] An uncompleted task
    - [ ] An uncompleted subtask
```


---
Adesso vediamo le immagini


![picture alt](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/Github-Markdown-Book/powered_by_n_solid.png "Title is optional")

    ![picture alt](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/Github-Markdown-Book/powered_by_n_solid.png "Title is optional")




Adesso vediamo i links


[Named Link](http://www.google.fr/ "Named link title") and http://www.google.fr/ or <http://example.com/>

    [Named Link](http://www.google.fr/ "Named link title") and http://www.google.fr/ or <http://example.com/>

[heading-1](#heading-1 "Goto heading-1")
    
    [heading-1](#heading-1 "Goto heading-1")


Link to a specific part of the page:

[Go To TOP](#TOP)
   
    Markup : [text goes here](#section_name)
              section_title<a name="section_name"></a>    

[![picture alt](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/Github-Markdown-Book/powered_by_n_solid.png "Title is optional")](http://www.google.fr/ "Named link title")

    [![picture alt](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/Github-Markdown-Book/powered_by_n_solid.png "Title is optional")](http://www.google.fr/ "Named link title")

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)

    [![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)


Adesso vediamo le tabelle

Table, like this one :

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

```
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell
```

Adding a pipe `|` in a cell :

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | \|

```
First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  |  \| 
```

Left, right and center aligned table

Left aligned Header | Right aligned Header | Center aligned Header
| :--- | ---: | :---:
Content Cell  | Content Cell | Content Cell
Content Cell  | Content Cell | Content Cell

```
Left aligned Header | Right aligned Header | Center aligned Header
| :--- | ---: | :---:
Content Cell  | Content Cell | Content Cell
Content Cell  | Content Cell | Content Cell
```

`code()`

    Markup :  `code()`

```javascript
    var specificLanguage_code = 
    {
        "data": {
            "lookedUpPlatform": 1,
            "query": "Kasabian+Test+Transmission",
            "lookedUpItem": {
                "name": "Test Transmission",
                "artist": "Kasabian",
                "album": "Kasabian",
                "picture": null,
                "link": "http://open.spotify.com/track/5jhJur5n4fasblLSCOcrTp"
            }
        }
    }
```

    Markup : ```javascript
             ```




_Image with alt :_

![picture alt](http://via.placeholder.com/200x150 "Title is optional")

    Markup : ![picture alt](http://via.placeholder.com/200x150 "Title is optional")

Foldable text:

<details>
  <summary>Title 1</summary>
  <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
</details>
<details>
  <summary>Title 2</summary>
  <p>Content 2 Content 2 Content 2 Content 2 Content 2</p>
</details>

    Markup : <details>
               <summary>Title 1</summary>
               <p>Content 1 Content 1 Content 1 Content 1 Content 1</p>
             </details>

```html
<h3>HTML</h3>
<p> Some HTML code here </p>
```

Hotkey:

<kbd>⌘F</kbd>

<kbd>⇧⌘F</kbd>

    Markup : <kbd>⌘F</kbd>

Hotkey list:

| Key | Symbol |
| --- | --- |
| Option | ⌥ |
| Control | ⌃ |
| Command | ⌘ |
| Shift | ⇧ |
| Caps Lock | ⇪ |
| Tab | ⇥ |
| Esc | ⎋ |
| Power | ⌽ |
| Return | ↩ |
| Delete | ⌫ |
| Up | ↑ |
| Down | ↓ |
| Left | ← |
| Right | → |

Emoji:

:exclamation: Use emoji icons to enhance text. :+1:  Look up emoji codes at [emoji-cheat-sheet.com](http://emoji-cheat-sheet.com/)

    Markup : Code appears between colons :EMOJICODE:
    
---

- ✨Magic ✨



```sh
cd dillinger
npm i
node app
```



---



# Managing Multiple Pages


There are currently two strategies for structuring multiple pages in one repository.


## Simple flat project with no hierarchy of pages

If your documents are going to consist of just a few pages, the simplest way to get started is just by placing all of your .md files in the root directory of your repository.  All files can link to each other directly without having to worry about paths.  For example README.md can link to file-a.md with \[File A](file-a.md).   file-b.md can links to file-a.md with \[File A](file-a.md).  File B can link to README.md with \[README.md](README.md). 

This strategy has the added benefit of working well on http://prose.io because you can create new files in a repository but you cannot create new folders.  However, your links will not path correctly when previewing them on Prose.io. 

As for images, you can place an image in the root directory and path the images as you would path to a page, or if you have a lot of images it can be "more elegant" to place them in an images directory and path them like \![Cool image](images/cool-image.png).  


## Complex project with a hierarchy of pages

Building on GitHub's subtle yet powerful README feature, you can create a hierarchy of posts using folders with the text for each folder saved as a README.md file in that folder's directory. If you are familiar with the behavior of index.html on web servers, you will feel right at home with this technique.  In this case, File A would not live in the root directory as file-a.md but instead lives in a folder named file-a with a text document README.md (file-a/README.md).  To link to File A from the root README.md file you would path a link like \[File A](file-a) which would then forward the user to the folder folder-a with GitHub displaying the current file-a/README.md file on the page.

This technique also has the advantage of keeping the images of each document close to the text of each document.  Do this by placing the images for each folder's README.md in the same folder as its corresponding README.md file. 



---


# Syntax highlighting

You can create fenced code blocks by placing triple backticks ``` before and after the code block. We recommend placing a blank line before and after code blocks to make the raw formatting easier to read.

```
function test() {
  console.log("notice the blank line before this function?");
}
```

Tip: To preserve your formatting within a list, make sure to indent non-fenced code blocks by eight spaces.


To display triple backticks in a fenced code block, wrap them inside quadruple backticks.

```` 
```
Look! You can see my backticks.
```
````

You can add an optional language identifier to enable syntax highlighting in your fenced code block.

For example, to syntax highlight Ruby code:

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

We use Linguist to perform language detection and to select third-party grammars for syntax highlighting. You can find out which keywords are valid in the languages YAML file.

[L'elenco dei linguaggi Ufficiale](https://github.com/github/linguist/blob/master/vendor/README.md)
[L'elenco dei linguaggi help list](https://github.com/github/linguist/blob/master/lib/linguist/languages.yml)
[L'elenco dei linguaggi samples](https://github.com/github/linguist/tree/master/samples)

Noi usiamo:

* ActionScript (forse)
* Batchfile (forse)
* CoffeeScript (forse)
* CSS
* CSV (non c'è nell'elenco ufficiale)
* cURL Config (forse)
* Diff (forse)
* Gemfile.lock (forse)
* Git Attributes (non c'è nell'elenco samples)
* Git Config (forse)
* HTML (forse)
* HTML+ERB
* JSON (forse)
* JavaScript
* JavaScript+ERB
* Lean (forse)
* Less (forse)
* Linux Kernel Module (forse. non c'è nell'elenco ufficiale)
* Markdown (forse)
* PLpgSQL (forse)
* PowerShell (forse)
* ruby
* SAS (forse)
* Sass (forse)
* SCSS (forse)
* Shell (forse)
* SQL (forse)
* Vue (forse)
* YAML
* 