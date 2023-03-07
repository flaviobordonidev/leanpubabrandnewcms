# <a name="top"></a> Cap active_record-seeds.6 - Unique records

Assicuriamoci che non ci siano record duplicati



## Risorse interne

- []()



## Risorse esterne

- []()



## Unique records
For some devs, it is common to run the seeds command `rails db:migrate` (or `rake db:migrate`) because sometimes they forget if they have already run them and, other times because they have edited a seed file (which should not be a problem nor create data duplication) that is easily fixed by adding the seeds data using the rails methods `find_or_create_by`. Following the appointments app example we would do something like this:

***Codice 01 - .../db/seeds/001_roles.rb - linea:01***

```ruby
Role.find_or_create_by(name: ‘Patient’) do |patient|
  Patient.availability = ‘8-5’
end
Role.find_or_create_by(name: ‘Doctor’)
```

***Codice 01 - .../db/seeds/002_users.rb - linea:01***

```ruby
patient_role = Role.find_by_name(‘Patient’)
doctor_role = Role.find_by_name(‘Doctor’)

User.find_or_create_by(first_name: ‘John’, last_name: ‘Doe’, role: patient_role)
User.find_or_create_by(first_name: ‘Janne’, last_name: ‘Doe’, role: doctor_role)
```

By saving the records like that, we can avoid duplicating the data that we already have in the DB (if any). You could try something a little bit different if you like/need to do so, nevertheless, I did it this way myself:

```ruby
patient_role = Role.find_by_name(‘Patient’)

User.where(first_name: ‘John’, last_name: ‘Doe’).first_or_create do |user|
user.role = patient_role
end
```

Hope this works for you. Thanks for reading! 


# db/seeds.rb

```ruby
User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = "12345678"
  user.password_confirmation = "12345678"
end if Rails.env.development?
```


