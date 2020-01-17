# Che tipo di dato è meglio usare per gestire prezzi?

è bene usare DECIMAL(19, 4)


Risorse web:

* https://www.guru99.com/postgresql-data-types.html
* https://stackoverflow.com/questions/224462/storing-money-in-a-decimal-column-what-precision-and-scale
* https://stackoverflow.com/questions/1019939/what-is-the-best-method-of-handling-currency-money
* https://rietta.com/blog/best-data-types-for-currencymoney-in/
* http://blog.plataformatec.com.br/2014/09/floating-point-and-currency/
* https://millarian.com/rails/precision-and-scale-for-ruby-on-rails-migrations/
* https://torontoprogrammer.ca/2010/05/decimal-numbers-in-rails-and-mysql/
* https://blog.francium.tech/postgress-numericvalueoutofrange-ad7bcb01f2f8




## Esempio di aggiunta di una colonna per gestire i prezzi


{caption: "terminal", format: bash, line-numbers: false}
```
$ rails g migration AddPriceToEgPosts price:decimal
```

{caption: ".../db/migrate/xxx_add_price_to_eg_posts.rb", format: ruby, line-numbers: true, number-from: 1}
```
class AddPriceToEgPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :eg_posts, :price, :decimal, precision: 19, scale: 4, default: 0
  end
end
```




## Che dimensione di DECIMAL?

Alcuni suggeriscono DECIMAL(13, 4).
altri suggeriscono DECIMAL(19, 4).

if someone uses sql, then DECIMAL(19, 4) is a popular choice check this also check here World Currency Formats to decide how many decimal places to use , hope helps


```
      t.decimal :amount, precision: 19, scale: 4, null: false
```

"Precision" defines the precision for the decimal fields, representing the total number of digits in the number.

"Scale" defines the scale for the decimal fields, representing the number of digits after the decimal point.




## for MySQL

If [GAAP Compliance](https://en.wikipedia.org/wiki/Generally_Accepted_Accounting_Principles_(United_States)) (Generally Accepted Accounting Principles) is required or you need 4 decimal places:

DECIMAL(13, 4)

Which supports a max value of:

$999,999,999.9999


Otherwise, if 2 decimal places is enough:

DECIMAL(13,2)

Which supports a max value of:

$99,999,999,999.99




## PostgreSQL Numeric Datatypes

PostgreSQL supports two distinct types of numbers:

Integers
Floating-point numbers
Name	Store size	Range
smallest	2 bytes	-32768 to +32767
integer	4 bytes	-2147483648 to +2147483647
bigint	8 bytes	-9223372036854775808 to 9223372036854775807

decimal	variable	If you declared it as decimal datatype ranges from 131072 digits before the decimal point to 16383 digits after the decimal point

numeric	variable	If you declare it as the number, you can include number up to 131072 digits before the decimal point to 16383 digits after the decimal point
real	4 bytes	6 decimal digits precision
double	8 bytes	15 decimal digits precision




## Decimal for Latitude and Longitude

For when you need that little bit of extra accuracy, specifying precision and scale for a decimal column in your Ruby on Rails migration is pretty simple. The precision represents the total number of digits in the number, whereas scale represents the number of digits following the decimal point. To specify the precision and scale, simply pass those as options to your column definition.

For example:

class AddLatLngToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :lat, :decimal, :precision => 15, :scale => 10
    add_column :addresses, :lng, :decimal, :precision => 15, :scale => 10
  end

  def self.down
    remove_column :addresses, :lat
    remove_column :addresses, :lng
  end
end
This will allow you to have 10 digits after the decimal point and 15 digits max.

One thing to note, however is that Rails will use BigDecimal as the type for the column.
