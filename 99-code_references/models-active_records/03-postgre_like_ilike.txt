# PostgreSQL LIKE ILIKE

http://stackoverflow.com/questions/4752705/case-insensitive-searches-queries


I'm looking to match address information.

Example:

123 main street
123 Main st.
123 Main Street
123 main st
123 Main st
etc...

any thoughts?

SELECT address FROM tbl WHERE address LIKE '%123 %ain%'

A.
Use ILIKE, e.g.:

...
WHERE
    address ILIKE '123 main st%'

Documentation. (http://www.postgresql.org/docs/7.3/static/functions-matching.html)

Alternatively you could use UPPER or LOWER, e.g.:

...
WHERE
    LOWER(address) LIKE '123 main st%'
