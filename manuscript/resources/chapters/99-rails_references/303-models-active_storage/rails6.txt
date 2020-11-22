# Rails 6 - Active Storage changes

Nov 4, 2019 , by Alkesh Ghorpade


## Riferimenti web

* https://blog.saeloun.com/2019/11/04/rails-6-active-storage-updates.html


Active Storage was introduced in Rails 5.2. In Rails 6, there are enhancements done to Active Storage.

Let’s explore them.

mini_magick replaced by image_processing gem
In Rails 5.2, Active Storage was using mini_magick to handle image resizing (variants).

In Rails 6, a new gem called image_processing is used by default to handle image variants. (commit)

The image_processing gem has below advantages:

New methods #resize_to_fit, #resize_to_fill, etc also sharpens the thumbnail after resizing.
It fixes the image orientation automatically. This can be referred here.
It provides another backend libvips that has significantly better performance than ImageMagick. With ImageMagick, resizing and sharpening a 1600x900 image to 800x800 is 1.87x slower, and to 300x300 is 1.18x slower. On libvips it doesn’t go above 1.20x slower, on average it’s only about 1.10x slower.
New image variants support
With addition of image_processing gem, support for new image variants BMP (PR), TIFF (PR) and progressive JPEG (PR) was introduced.

Fix for has_many_attached field in update query
Let’s say we have a User class and it has field images. Users can upload multiple images to their profiles. So we add has_many_attached method to User class as shown below

class User < ApplicationRecord
  has_many_attached :images
end
Before Rails 6:
We attach an image to the user as shown below and verify the count

user = User.first
user.images.attach(filename: "profile_pic.jpg")

user.images.count
=> 1
Now, when we update the image field, the new image was getting appended to the existing images collection.

blog = ActiveStorage::Blob.create_after_upload!(filename: "updated_pic.jpg")
user.update(images: [blog])

user.images.count
=> 2
user.images.first.filename
=> "profile_pic.jpg"
user.images.last.filename
=> "updated_pic.jpg"
This is not consistent with ActiveRecord update, where it replaces the existing value of a record.

In Rails 6:
update query replaces the existing collection instead of appending to the collection.

user.images.attach(filename: "profile_pic.jpg")

user.images.count
=> 1

blog = ActiveStorage::Blob.create_after_upload!(filename: "updated_pic.jpg")
user.update(images: [blog])

user.images.count
=> 1
user.images.first.filename
=> "updated_pic.jpg"
Note:

We can append files by using the attach function.

More changes related to Active Storage can be found here. https://edgeguides.rubyonrails.org/6_0_release_notes.html#active-storage
