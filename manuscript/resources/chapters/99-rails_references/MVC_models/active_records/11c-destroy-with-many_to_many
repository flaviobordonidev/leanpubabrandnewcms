


* https://stackoverflow.com/questions/34666902/how-to-destroy-a-record-when-there-is-many-to-many-relationship-in-ruby-on-rails



## Example 1

Question

In my app there is recipes and ingredients, so a recipe can have many ingredients and a ingredient can be used in many recipes, everything is ok and when I create recipes there is a table called Has_ingredient where is saved every ingredient per recipe.

The thing is, now when I try to destroy a recipe there is a error, because I need to destroy the record in Has_ingredient associated with that recipe before delete the recipe.

So in my model I created something like this

class Recipe < ActiveRecord::Base

```
    before_destroy :destroy_ingredents
    ....
    ....
    ....
    def destroy_ingredents

       HasIngredent.destroy(recipe_id: self.id)
    end
```

Well, now I get this error: OCIERROR: ORA-00904.
So now the problem is not Rails, but the database (Im using Oracle), but im pretty sure the problem is how im using destroy method but I cant figure how to use it properly to delete every record in has_ingredent table associated with certain recipe


Answer

The best way to destroy the children would be using the dependent

So in your model, you would have:

```
class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :destroy
end
```

However if you want to know the correct syntax:

```
HasIngredent.find_by(recipe_id: self.id).destroy 
```
