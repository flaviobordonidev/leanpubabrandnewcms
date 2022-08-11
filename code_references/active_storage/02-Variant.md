# L'uso di "variant" per modificare le immagini

Risorse web:

* [ActiveStorage variant method](http://www.carlosramireziii.com/what-options-can-be-passed-to-the-active-storage-variant-method.html)
* [ImageMagick resize](https://www.imagemagick.org/Usage/resize/)
* [ImageMagick crop](https://www.imagemagick.org/Usage/crop/)
* [ImageMagick geometry](http://www.imagemagick.org/script/command-line-processing.php#geometry)
* [ImageMagick list of commands](https://www.imagemagick.org/script/command-line-options.php)




## Come passare i parametri

For options which need a parameter, the key is the name of the flag and the value is its parameter.

~~~~~~~~
my_attachment.variant(resize: "100x100")
~~~~~~~~

For options which don’t need a parameter, the key is also the name of the flag, but the value should be set to true.

~~~~~~~~
my_attachment.variant(auto_orient: true)
~~~~~~~~

By default, the image transformations passed to variant are applied sequentially. But some advanced transformations need to occur at the same time. For example, an image with cropping + centering + colored whitespace background.

In cases like this, you’ll need to use combine_options.

The following example resizes an image such that it’s no larger than 400x300 and fills in any whitespace with a grey background color.

~~~~~~~~
my_attachment.variant(combine_options: { resize: "400x300>", crop: "400x300+0+0", background: "grey", gravity: "center"})
~~~~~~~~

I use this technique for grids of user uploaded images. It makes all the images exactly the same size, even if the originals had different aspect ratios.


Esempio:

<%= image_tag @user.account_image.variant(combine_options: {resize: '100>', gravity: 'Center', crop: '100x100+0+0' }), style: "border-radius: 50%" %>



## I comandi più usati

* resize  : per ridimensioare le immagini
* crop    : per ritagliare le immagini (sarebbe meglio "Extend")
* gravity : per "allineare" l'immagine nel ritaglio




### Crop

The "-crop" image operator will simply cut out the part of all the images in the current sequence at the size and position you specify by its geometry argument.

  convert rose:                    rose.gif
  convert rose: -crop 40x30+10+10  crop.gif
  convert rose: -crop 40x30+40+30  crop_br.gif
  convert rose: -crop 40x30-10-10  crop_tl.gif
  convert rose: -crop 90x60-10-10  crop_all.gif
  convert rose: -crop 40x30+90+60  crop_miss.gif




### Extend 

"Estende" le funzionalità di crop facendo anche una pulizia automatica dei layers usati per il ritaglio

Though the "-crop" is most logical, it may require an extra "+repage" to remove virtual canvas layering information. The "-extent" does not require this cleanup.

Extent, Direct Image Size Adjustment
After some discussions on the ImageMagick Mailing List, a operator to directly adjust the final size of an image size was added to ImageMagick version 6.2.4. The "-extent" operator.
If the image size increases, space will be added to right or bottom edges of the image. If it decreases the image data is just junked or cropped to fit the new image size.

Ad oggi 22-02-2019 la funzione extend non mi funziona su "Variant".



### Geometry

size	              General description (actual behavior can vary for different options and settings)
---------------------------------------------------------------------------------------
scale%	            Height and width both scaled by specified percentage.
scale-x%xscale-y%	  Height and width individually scaled by specified percentages. (Only one % symbol needed.)
width	              Width given, height automagically selected to preserve aspect ratio.
xheight	            Height given, width automagically selected to preserve aspect ratio.
widthxheight	      Maximum values of height and width given, aspect ratio preserved.
widthxheight^	      Minimum values of width and height given, aspect ratio preserved.
widthxheight!	      Width and height emphatically given, original aspect ratio ignored.
widthxheight>	      Shrinks an image with dimension(s) larger than the corresponding width and/or height argument(s).
widthxheight<	      Enlarges an image with dimension(s) smaller than the corresponding width and/or height argument(s).
area@	              Resize image to have specified area in pixels. Aspect ratio is preserved.
x:y	                Here x and y denotes an aspect ratio (e.g. 3:2 = 1.5).
{size}{offset}	    Specifying the offset (default is +0+0). Below, {size} refers to any of the forms above.
{size}{+-}x{+-}y	  Horizontal and vertical offsets x and y, specified in pixels. Signs are required for both. Offsets are affected by ‑gravity setting. Offsets are not affected by % or other size operators.
