# <a name="top"></a> Cap pagination.3 - Get next / previous record

Passiamo al prossimo elemento.

> In realtà questa parte non c'entra niente con il pagination ma mi è venuto in mente il pagination come associazione di scorrere al prossimo set di records.
>
> Probabilmente in futuro la sposto su una cartella più appropriata e qui lascio solo un riferimento.

La difficoltà di passare all'elemento successivo è che gli id dei records non sono sempre consecutivi perché a volte alcuni records sono cancellati.

> A common use case is that Database IDs are not regular. 
> For example my record IDs are [3, 10, 11, 13, 14] and the next element to id => 3 is id => 10.



## Risorse interne

- [ubuntudream/15-lessons-steps/04_00-steps_sequence]()

Scorriamo tra i passi (*steps*) di una lezione (*lesson*)



## Risorse esterne

- [Rails: Get next / previous record](https://stackoverflow.com/questions/7394088/rails-get-next-previous-record)
- [Rails best way to get previous and next active record object](https://stackoverflow.com/questions/25665804/rails-best-way-to-get-previous-and-next-active-record-object/25712023#25712023)
- [gem 'order_query'](https://github.com/glebm/order_query)



## Rails: Get next / previous record

My app has Photos that belong to Users.

In a photo#show view I'd like to show "More from this user", and show a next and previous photo from that user. I would be fine with these being the next/previous photo in id order or the next/previous photo in created_at order.

How would you write that kind of query for one next / previous photo, or for multiple next / previous photos?

Try this:

```ruby
class User
  has_many :photos
end


class Photo
  belongs_to :user

  def next
    user.photos.where("id > ?", id).first
  end

  def prev
    user.photos.where("id < ?", id).last
  end

end
```

Now you can:

```ruby
photo.next
photo.prev
```



## The solution when there is no association involved

It lead me to a solution for my problem as well. I was trying to make a next/prev for an item, no associations involved. ended up doing something like this in my model:

```ruby
  def next
    Item.where("id > ?", id).order("id ASC").first || Item.first
  end

  def previous
    Item.where("id < ?", id).order("id DESC").first || Item.last
  end
```

This way it loops around, from last item it goes to the first one and the other way around. I just call @item.next in my views afterwards.
