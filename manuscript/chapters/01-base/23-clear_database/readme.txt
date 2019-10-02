## DATABASE BACKUP AND RESTORE

Poiché il database ed i dati non sono passati su github ci serve un modo per gestirli.
In questo capitolo gestiamo la parte di dati per il database di sviluppo


* [Backup and Restore a PostgreSQL Database](https://axiomq.com/blog/backup-and-restore-a-postgresql-database/)
* [Recover Data from Production Backups with ActiveRecord](https://thoughtbot.com/blog/recover-data-from-production-backups-with-activerecord)
* [Importing and Exporting Heroku Postgres Databases](https://devcenter.heroku.com/articles/heroku-postgres-import-export)

* [Backing Up and Restoring a Database](http://tutorials.jumpstartlab.com/topics/devops/backing_up_and_restoring_a_database.html)
* [How to backup/restore Rails db with Postgres?](https://stackoverflow.com/questions/18723675/how-to-backup-restore-rails-db-with-postgres)

* [How to remove old database migrations in Ruby on Rails](https://naturaily.com/blog/remove-old-migrations-ruby-on-rails)
* [Rails Migrations Tricks - Guide + Code](https://medium.com/forest-admin/rails-migrations-tricks-guide-code-cheatsheet-included-dca935354f22)
* [ Populating the Database with seeds.rb](http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html)

rake db:drop db:create db:migrate



## Restore the backup locally
The project was deployed on Heroku and using Heroku’s PGBackups feature for both scheduled (daily) and manual backups.

[heroku pg:backups](https://devcenter.heroku.com/articles/heroku-postgres-backups)

We had already captured a backup of the production database before rolling out the faulty process with heroku pg:backups capture --app app-production. That backup was assigned an identifier by Heroku, in this case b046.

To restore that backup locally, then, we used:

curl -o backup.dump heroku pg:backups public-url b046 
createdb backup 
pg_restore -d backup backup.dump

With a complete copy of production data available locally, we were able to start scripting the recovery process.




## SAVE RESTORE PostgreeSQL DB

I use this command to save my database:

pg_dump -F c -v -U postgres -h localhost <database_name> -f /tmp/<filename>.psql
And this to restore it:

pg_restore -c -C -F c -v -U postgres /tmp/<filename>.psql
This dumps the database in Postgres' custom format (-F c) which is compressed by default and allows for reordering of its contents. -C -c will drop the database if it exists already and then recreate it, helpful in your case. And -v specifies verbose so you can see exactly what's happening when this goes on.

...The problem here is that the pg_restore restores the database register_production, and I want the data restored to register_development on my local machine. – croceldon Sep 10 '13 at 16:26
Hi! I have a problem with this command. I receive the following error: pg_dump: [archiver (db)] query failed: ERROR: permission denied for relation schema_migrations . What could be a problem? Thanks! – user3304086 Feb 21 '14 at 1:36
fwiw if running postgres locally on a Rails development machine you generally will omit the -U postgres parameter – jpwynn Feb 6 '15 at 19:51
Sorry for hijacking. I've been trying to restore the database as per your command above. It looks like it's working as in I see a load of commands. But when I go in and have a look, none of the data has copied in. Any ideas? – Al D May 14 '15 at 19:04
I had the same issue as AI D, the pg_restore just dumps the the contents to STDOUT. I fixed this by adding the -d <database_name> to the pg_restore command. – TomDavies Sep 21 '15 at 15:24

I'm unable to find this psql file in my tmp folder. where it will generate ? – Jai Kumar Rajput May 30 '16 at 12:56
how should i give the file path when i use windows machine . this is my command pg_dump -F p -U test -h localhost octopus_test -f C:\Users\Proobook\Desktop\Newfolder\test.sql – Saranga kapilarathna Apr 27 '17 at 5:04 
Use rake db:drop and rake db:create (without seed/migrate) instead of pg_dump -c -C as these options drop/create the given name but restore into DB named in archive. – Beni Cherniavsky-Paskin Sep 19 '17 at 13:38
@BeniCherniavsky-Paskin any idea on whether or not you'd first want to use the rake db:schema:load? – karns Aug 13 at 23:54


-----------------------------
ATTENZIONE: CODICE DI RAILS 3 

Questi esempi di populate sono con codice parecchio vecchio...

## 4.5. Populating the Database with seeds.rb

With the file db/seeds.rb, the Rails gods have given us a way of feeding default values easily and quickly to a fresh installation. This is a normal Ruby program within the Rails environment. You have full access to all classes and methods of your application.
So you do not need to enter everything manually with rails console in order to make the records created in the section called “create” available in a new Rails application, but you can simply use the following file db/seeds.rb:

~~~~~~~~
Country.create(name: 'Germany', population: 81831000)
Country.create(name: 'France', population: 65447374)
Country.create(name: 'Belgium', population: 10839905)
Country.create(name: 'Netherlands', population: 16680000)
~~~~~~~~

You then populate it with data via rake db:seed. To be on the safe side, you should always set up the database from scratch with rake db:setup in the context of this book and then automatically populate it with the file db/seeds.rb. Here is what is looks like:

~~~~~~~~
$ rake db:setup
db/development.sqlite3 already exists
-- create_table("countries", {:force=>true})
   -> 0.0175s
-- initialize_schema_migrations_table()
   -> 0.0005s
-- assume_migrated_upto_version(20121114110230, ["/Users/xyz/sandbox/europe/db/migrate"])
   -> 0.0006s
$
~~~~~~~~

I use the file db/seeds.rb at this point because it offers a simple mechanism for filling an empty database with default values. In the course of this book, this will make it easier for us to set up quick example scenarios.




### It's all just Ruby code

The db/seeds.rb is a Ruby program. Correspondingly, we can also use the following approach as an alternative:

~~~~~~~~
country_list = [
  [ "Germany", 81831000 ],
  [ "France", 65447374 ],
  [ "Belgium", 10839905 ],
  [ "Netherlands", 16680000 ]
]

country_list.each do |name, population|
  Country.create( name: name, population: population )
end
~~~~~~~~

The result is the same. I am showing you this example to make it clear that you can program completely normally within the file db/seeds.rb.




### Generating seeds.rb From Existing Data

Sometimes it can be useful to export the current data pool of a Rails application into a db/seeds.rb. While writing this book, I encountered this problem in almost every chapter. Unfortunately, there is no standard approach for this. I am showing you what you can do in this case. There are other, more complex scenarios that can be derived from my approach.
We create our own little rake task for that. That can be done by creating the file lib/tasks/export.rake with the following content:

~~~~~~~~
namespace :export do
  desc "Prints Country.all in a seeds.rb way."
  task :seeds_format => :environment do
    Country.order(:id).all.each do |country|
      puts "Country.create(#{country.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end
~~~~~~~~

Then you can call the corresponding rake task with the command rake export:seeds_format:

~~~~~~~~
$ rake export:seeds_format
Country.create("name"=>"Germany", "population"=>81831000)
Country.create("name"=>"France", "population"=>65447374)
Country.create("name"=>"Belgium", "population"=>10839905)
Country.create("name"=>"Netherlands", "population"=>16680000)
$
~~~~~~~~

You can either expand this program so that the output is written directly into the db/seeds.rb or you can simply use the shell:

~~~~~~~~
$ rake export:seeds_format > db/seeds.rb
$ 
~~~~~~~~




### UTF-8

If you want to use UTF-8 characters in your db/seeds.rb, then you need to enter the line

~~~~~~~~
# ruby encoding: utf-8
~~~~~~~~

at the beginning of the file.
Example:

~~~~~~~~
# ruby encoding: utf-8
Country.create(name: 'Germany', population: 81831000)
Country.create(name: 'France', population: 65447374)
Country.create(name: 'Belgium', population: 10839905)
Country.create(name: 'Netherlands', population: 16680000)
Country.create(name: 'Austria', population: 8440465)
Country.create(name: 'Republika e Shqipërisë', population: 2831741)
~~~~~~~~
