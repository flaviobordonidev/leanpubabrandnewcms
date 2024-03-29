# <a name="top"></a> Cap 39.80 - Come fare le ricerche senza usare Ransack



## Risorse interne

- []()



## Risorse esterne

- []()



## Apriamo il branch




## Mobility gem + Rails : how to perform a join with LIKE query on a translated model


I had this query working before implementing Mobility on my app :

```ruby
Product.joins(:category).where('categories.name ILIKE ANY ( array[?] )', categories)
```

where `categories` is `= params[:categories].map {|category| "%#{category}%" }`

After having implemented **Mobility gem**, the query output was obviously: []

Thus I tried adding `.i18n` as stated in gem doc: 

```ruby
Product.i18n.joins(:category).where('categories.name ILIKE ANY ( array[?] )', categories)
```

--> Outputs [], as it doesn't join on the translated table : SELECT "products".* FROM "products" INNER JOIN "categories" ON "categories"."id" = "products"."category_id" WHERE (categories.name ILIKE ANY ( array['%Categorie test%'] ))

Then I tried to join category translated table without success. I tried to inspire my query with following question. But all these queries **fail** :

```ruby
Product.i18n.joins(:category).joins(:translations).where('categories.name ILIKE ANY ( array[?] )', categories)
Product.i18n.joins(:category).join_translations.where('categories.name ILIKE ANY ( array[?] )', categories)
Product.i18n.joins(:mobility_string_translations).where('categories.name ILIKE ANY ( array[?] )', categories)
Product.i18n.joins(:category_name_fr_string_translations).where('categories.name ILIKE ANY ( array[?] )', categories)
Returning either : undefined method join_translations or Can't join 'Product' to association association_name '
```

How can I join category and query with ILIKE to get translated outputs?

Thanks to Chris' help, here is the working Arel query for whoever might be interested :

```ruby
Product.joins(:category).merge(Category.i18n {name.matches_any(categories)})
```




---

[<- back](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/09-manage_users/03_00-browser_tab_title_users-it.md)
 | [top](#top) |
[next ->](https://github.com/flaviobordonidev/leanpubabrandnewcms/blob/master/01-base/10-users_i18n/02_00-users_form_i18n-it.md)
