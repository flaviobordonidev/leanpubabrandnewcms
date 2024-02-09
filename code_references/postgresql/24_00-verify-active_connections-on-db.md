

## Verifica di connessioni attive

Verifichiamo se ci sono delle connessioni attive sui databases "s5beginning_development" e "s5beginning_test"

```sql
> SELECT
>     *
> FROM
>     pg_stat_activity
> WHERE
>     datname = 's5beginning_development';


postgres=# SELECT
postgres-# *
postgres-# FROM
postgres-# pg_stat_activity
postgres-# WHERE
postgres-# datname = 's5beginning_development';
 datid | datname | pid | usesysid | usename | application_name | client_addr | client_hostname | client_port | backend_start | xact_start | query_start | state_change | wait_event_type | wait_event | state | backend_xid | backend_xmin | query | backend_type 
-------+---------+-----+----------+---------+------------------+-------------+-----------------+-------------+---------------+------------+-------------+--------------+-----------------+------------+-------+-------------+--------------+-------+--------------
(0 rows)

postgres=# 
```

