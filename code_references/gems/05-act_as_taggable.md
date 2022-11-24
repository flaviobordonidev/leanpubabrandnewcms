# Act as taggable


## Risorse esterne

- [Acts as Taggable On Tutorial with Rails 5](https://medium.com/le-wagon/acts-as-taggable-on-tutorial-with-rails-5-417a862804b6)

- [acts-as-taggable-on - gorails: Recommended](https://gorails.com/tool_categories/tags-tagging/tools)
- [mbleigh/acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
- [gem: acts-as-taggable-on](https://rubygems.org/gems/acts-as-taggable-on)

- [Tags In Rails 7 With Many To Many Relationship | Ruby On Rails Tutorial](https://www.youtube.com/watch?v=03enr4NNgLI)




## Useful Acts_As_Taggable Methods

```ruby
#returns most and least used tags
ActsAsTaggableOn::Tag.most_used(10)
ActsAsTaggableOn::Tag.least_used(10)

#force all tags to be saved as lowercase
ActsAsTaggableOn.force_lowercase = true

#add tags separated by comma (default), can change to space or others
ActsAsTaggableOn.delimiter = ','
```


Related Gems
Acts As Favoritor — https://github.com/jonhue/acts_as_favoritor
Acts As Votable (Likable) — https://github.com/ryanto/acts_as_votable