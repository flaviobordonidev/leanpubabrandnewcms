---
https://www.linkedin.com/pulse/12-gems-every-rails-developer-should-know-2016-stayman-hou
1. devise - Authentication
2. CanCanCan - Authorization
3. Kaminari - Pagination
4. Ransack - Scoping/Searching/Filtering
5. twitter-bootstrap-rails - Frontend
6. CarrierWave - User Generated Files
7. Searchkick - Intelligent Searching (Nature Language)
8. Metamagic - SEO
9. rails_config - Configuration
10. Sequel - ORM (ActiveRecord Alternative)
11. RuboCop - Static Code Analyzer, Code Smell
12. Brakeman - Static Code Analyzer, Security

---
https://blog.planetargon.com/entries/8-useful-ruby-on-rails-gems-we-couldnt-live-without


Pundit – User Authorization (https://github.com/elabs/pundit)
Someone new to web development (or outside stakeholders on a project) might confuse authorization and authentication. Authorization decides what abilities a user has on a certain application or website. If you’ve ever received an error message that you didn’t have proper admin rights to perform a task on an application, you’ve seen user authorization in action.
Pundit solves common authorization issues in the most “Rails” way possible. It’s easy to configure and customize across a wide range of applications. It’s a super useful Gem to keep in your back pocket.

WebPacker – Javascript Management (https://github.com/rails/webpacker#work-left-to-do)
JavaScript is constantly changing. For years, Rails has lacked a simple bundling system for JS assets. Webpacker resolves this by allowing you to decide how to manage assets. It’s a handy tool to familiarize yourself with, as this methodology is likely the future of how we serve up assets that were previously provided by Rails sprockets. This gem will also be baked right into Rails 5.1.

Smarter CSV – CSV Import (https://github.com/tilo/smarter_csv)
The process of importing massive CSV files into an application’s database can be a doozy. Unlike most CSV parsers, Smarter CSV can process the stream in smaller sections. This was a big help on a project where the existing import process was timing out on spreadsheets with large amounts of records.
Utile per Donachiaro

Bundler – Audit (https://github.com/rubysec/bundler-audit)
Updates and fixes can leave your program with small security vulnerabilities that are hard to catch. Bundler performs a thorough audit of your application’s Gem version and produces a report of any security issues that need to be patched. Each issue is given a level of criticality and upgrade solutions.

Rails ERD – ActiveRecord Diagrams (https://github.com/voormedia/rails-erd)
In the discovery phase of an existing application, learning how different models in a project relate to each other can be a tedious and confusing process. Rails ERD generates diagrams of your ActiveRecord Models to help you visualize connections and dependencies.

Chartkick – Chart Creator (https://github.com/ankane/chartkick)
This gem creates stunning Javascript charts with one line of Ruby, saving you time spent working with charting libraries. While it’s not the most extensive data visualization tool, it’s speedy. You can go from nothing to engaging charts and graphs in just a few minutes.

Annotate – Annotate Rails Classes (https://github.com/ctran/annotate_models)
New developers or anyone working on a large application with a complex data structure will find Annotate to be a lifesaver. This Gem annotates Rails classes with schema and routes info. On projects where the schema is kept in sql format, Annotate will save you from looking at migration files or spinning up an instance in the console when you need to know about the attributes on a model.

MetaTags – SEO-Friendly Rails Apps (https://github.com/kpumuk/meta-tags)
SEO can sometimes feel like deciphering hieroglyphics. Experts guess on new aspects of Google’s algorithm nearly every week, but there are a few staples of SEO that have remained integral for years. MetaTags simplifies SEO by allowing you to easily set all of the tags and descriptions you need for your web page.
This SEO Gem handles canonical URLs, Open Graph tags, Twitter tags, titles, descriptions, and more. You can even set defaults for particular pages.
