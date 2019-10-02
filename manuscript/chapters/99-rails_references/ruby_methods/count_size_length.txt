# Il numero di elementi in una lista



Risorse web:

* [activerecordrelation-size-vs-count](https://til.hashrocket.com/posts/620981e2e4-activerecordrelation-size-vs-count)
* [3 ActiveRecord Mistakes That Slow Down Rails Apps: Count, Where and Present](https://www.speedshop.co/2019/01/10/three-activerecord-mistakes.html)




## ActiveRecord::Relation size vs count

An array in ruby has 3 methods that do the same thing. size, count, and length all return the number of items in an array.

An ActiveRecord::Relation however uses them a bit differently. count is always going to run a query in the database while size will return the number of items in the collection based on the objects currently in the object graph.

> songs  = Songs.all
> songs.size
10

> songs.count
SELECT count(*) FROM songs;
10




## 3 ActiveRecord Mistakes That Slow Down Rails Apps: Count, Where and Present --> Count

Use "SIZE"

In my opinion, most Rails developers should be using size in most of the places that they use count. 
I’m not sure why everyone seems to write count instead of size. size uses count where it is appropriate, and it doesn’t when the records are already loaded. I think it’s because when you’re writing an ActiveRecord relation, you’re in the “SQL” mindset. You think: “This is SQL, I should write count because I want a COUNT!”

So, when do you actually want to use count? Use it when you won’t actually ever be loading the full association that you’re counting. 




## ESEMPIO usato su .build per la posizione dell'ultimo paragrafo inserito 

Nel campo posizione-nella-lista dell'ultimo paragrafo " @post.post_paragraphs.last.list_position " inseriamo il valore di tutti i paragrafi messi " @post.post_paragraphs.size "

{title=".../app/controllers/authors/posts_controller.rb", lang=ruby, line-numbers=on, starting-line-number=83}
~~~~~~~~
  # GET /posts/1/edit
  def edit
    @post.post_paragraphs.build
    @post.post_paragraphs.last.list_position = @post.post_paragraphs.size
    #raise "post_paragraphs.last.list_position = #{@post.post_paragraphs.last.list_position}"
    #raise "last_pos = #{@post.post_paragraphs.size + 1} il + 1 non serve"
  end
~~~~~~~~

