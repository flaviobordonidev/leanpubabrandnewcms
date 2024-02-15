# <a name="top"></a> Cap i18n_dynamic_database.2 - Internazionalizziamo gli articoli

Usiamo la ricerca con la gemma `ransack` e `mobility` per avere ricerche in più lingue.



## Risorse interne

- []()



## Risorse esterne

- [Mobility Ransack by shioyama](https://github.com/shioyama/mobility-ransack)
- [rubygem: mobility-ransack](https://rubygems.org/gems/mobility-ransack)
- [Mobility main site: Riferimento a mobility-ransack ](https://github.com/shioyama/mobility#integrations)

- [ransack](https://activerecord-hackery.github.io/ransack/getting-started/simple-mode/)

- [Ransack search include parameter](https://stackoverflow.com/questions/35750932/ransack-search-include-parameter)

- [Search And Sort In Ruby On Rails 6 With The Rails Ransack Gem](https://www.youtube.com/watch?v=qWObWACNY9g)
- [Search And Sort In Ruby On Rails 6 With The Rails Ransack Gem part2](https://www.youtube.com/watch?v=rtg-5EXwpbg)
- [Search And Sort In Ruby On Rails 6 With The Rails Ransack Gem part3](https://www.youtube.com/watch?v=IexdVzZBOrU&t=3s)




- [Polyglot content in a rails app](https://revs.runtime-revolution.com/polyglot-content-in-a-rails-app-aed823854955)



## Search Matchers

- [Search Matchers](https://activerecord-hackery.github.io/ransack/getting-started/search-matches/)


Predicate	| Description       |	Notes
:-        | :-                | :-
*_eq	    | equal	            |
*_not_eq	| not equal         |
*_matches	| matches with LIKE	| e.g. q[email_matches]=%@gmail.com

...






## Ransack search include parameter

I'm using gem 'ransack' to search records.

The page I'm programming starts with ONLY a dropdown to select @department. After that, I want Ransack to search within @department.

I need to include an additional parameter department=2 with the Ransack search parameters. (It works if I insert that into the browser URL).

Browser URL after I type in department=2

```
http://localhost:5000/departments/costfuture?department=2&utf8=%E2%9C%93&q%5Bid_eq%5D=&q%5Bproject_year_eq%5D=&q%5Boriginal_year_eq%5D=&q%5Bclient_id_eq%5D=43&q%5Blocation_name_cont%5D=&q%5Bproject_name_cont%5D=&q%5Bcoststatus_id_in%5D%5B%5D=&q%5Bcoststatus_id_not_in%5D%5B%5D=&q%5Brebudget_true%5D=0&q%5Bnew_true%5D=0&q%5Bconstruction_true%5D=0&q%5Bmaintenance_true%5D=0&commit=Search
```

This is the controller:

```ruby
  def costfuture

    @departments = current_user.contact.departments
    if params[:department]
      @department = Department.find(params[:department])
      @search = @department.costprojects.future.search(params[:q])
      @costprojects = @search.result.order(:department_priority)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departments }
    end
  end
```


I tried this in the view:

```html+erb
<%= search_form_for @search, url: departments_costfuture_path(:department => @department.id) do |f| %>
```

But, the resulting URL is missing the department=2.


### Answer 1

I ended up using hidden_field_tag inside search_form_for.

```html+erb
<%= search_form_for @search, url: departments_costfuture_path do |f| %>
  <%= hidden_field_tag :department, @department.id %>
  <%= f.search_field :last_name_or_first_name_cont %>
<% end %>
```

Then `params[:department]` and `params[:search]` will be accessible in the controller.


### Answer 2

If you want to pass the department option through to Ransack, you can do this with a hidden field within your search_form_for:

```html+erb
<%= search_form_for @search, url: departments_costfuture_path do |f| %>
  <%= f.hidden_field :department_eq, value: @department.id %>
  <%# Other form code here %>
<% end %>
```

But if you want to search a particular department, then it's better to use Rails routes for that. You can generate URLs like /departments/2/costfuture by modifying config/routes.rb:

```ruby
resources :departments do
  get 'costfutures', on: :member
end
```

Now you can use the resulting URL helper to generate links that will set `params[:id]`, and you can use that to retrieve `@department`.


Thanks for the help - but, that line gives me "undefined method `merge' for 2:Fixnum" – 
Reddirt

That's going to be tricky to track down without seeing the full error & your controller action (and maybe your model definition too). Could you add those to your question, please? – 
Alex P

This worked in the view <%= f.hidden_field :department_eq, :value => @department.id %>. But, I need to extract the department=x from the params[:q]. Do know how to do that? – 
Reddirt

This worked in the controller - to get the hidden department_eq - ` @department = params[:q][:department_eq]` – 
Reddirt

Thanks for the updates – I've added some more details to my answer. :) – 
Alex P


---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/24-dynamic-i18n/01_00-install_i18n_globalize-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/25-nested_forms_with_stimulus/01_00-stimulus-mockup-it.md)
