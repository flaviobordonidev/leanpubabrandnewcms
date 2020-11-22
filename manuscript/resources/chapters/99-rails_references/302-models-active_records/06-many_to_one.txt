# many_to_one association

Associazione molti-a-uno


*****
https://www.sitepoint.com/brush-up-your-knowledge-of-rails-associations/
http://blog.bigbinary.com/2016/03/01/migrations-are-versioned-in-rails-5.html
http://guides.rubyonrails.org/association_basics.html#self-joins
*****


## Subject model
  has_many :pages




## Page model
  belongs_to :subject #has the foreign key (subject_id)
  has_many :sections




## Section model
  belongs_to :page #has the foreign key (page_id)

subject.pages
subject.pages << page
subject.pages = [page, page, page]
subject.pages.delete(page)
subject.pages.clear
subject.pages.empty?
subject.pages.size


rails c
  subject = Subject.find(1)
  subject.pages
  first_page = Page.new(:name => "First Page", :permalink => "first", :position => 1)
  subject.pages << first_page
  y subject.pages
  second_page = Page.new(:name => "Second Page", :permalink => "second", :position => 2)
  subject.pages << second_page
  y subject.pages
  subject.pages.size
  subject.pages.empty?
  subject.pages.delete(second_page)
  subject.pages.size
  subject.pages[0].sections
