# <a name="top"></a> Cap mix_and_go - SQLite Database

SQLite è un database che risiede all'interno di un file che è sul *db* folder (`.../db`)

> Non è un'applicazione separata, come mysql o postgresql, ma è una libreria.



## Creiamo il model Person

```bash
rails g model Person name:string age:integer married:boolean
rails db:migrate
```



## Popoliamo la tabella

```bash
rails c
Person.new(name: "Anna", age: 32, married: false).save
Person.create(name: "Barbara", age: 54, married: true)
p1 = Person.new
p1.name = "Carlo"
p1.age = 15
p1.married = false
p1.save
Person.all
```



## Apriamo una "database console" SQLite

```bash
$ rails db
-> .tables
-> INSERT INTO users (name, email, bio, age, happy, created_at, updated_at) VALUES ("John", "john@example.com", "", 25, true, "2022-01-01", "2022-01-01");
-> .mode column
-> SELECT * FROM people;
-> .quit
```

> `.mode column` formatta il risultato in modo più leggibile.

Esempio:

```bash
ubuntu@ubuntufla:~/eduport $rails db
SQLite version 3.31.1 2020-01-27 19:55:54
Enter ".help" for usage hints.
sqlite> select * from people;
1|Anna|32|0|2022-05-23 10:40:43.563084|2022-05-23 10:40:43.563084
2|Barbara|54|1|2022-05-23 10:40:54.574084|2022-05-23 10:40:54.574084
3|Carlo|15|0|2022-05-23 10:41:34.922117|2022-05-23 10:41:34.922117
sqlite> .mode column
sqlite> select * from people;
1           Anna        32          0           2022-05-23 10:40:43.563084  2022-05-23 10:40:43.563084
2           Barbara     54          1           2022-05-23 10:40:54.574084  2022-05-23 10:40:54.574084
3           Carlo       15          0           2022-05-23 10:41:34.922117  2022-05-23 10:41:34.922117
sqlite> .quit
```
