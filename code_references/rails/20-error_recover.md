# <a name="top"></a> Cap multipass_ubuntu.88 - Multipass Error recover

Ripristiniamo una sessione bloccata di server rails



## How to recover from rails s already running

Se proviamo a far partire il web server rails con `rails -s ...` e ci dice che c'è un processo già attivo, allora possiamo uccidere il processo attivo e riprovare.

```bash
$ sudo kill -9 <PID>
```

> per vedere tutti i processi attivi `$ ps aux`.

Esempio:

```shell
ubuntu@ub22fla:~/ubuntudream$ rails s -b 192.168.64.4
=> Booting Puma
=> Rails 7.1.3 application starting in development 
=> Run `bin/rails server --help` for more startup options
A server is already running (pid: 10242, file: /home/ubuntu/ubuntudream/tmp/pids/server.pid).
Exiting

ubuntu@ub22fla:~/ubuntudream$ sudo kill -9 10242

ubuntu@ub22fla:~/ubuntudream$ rails s -b 192.168.64.4
=> Booting Puma
=> Rails 7.1.3 application starting in development 
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 6.4.2 (ruby 3.3.0-p0) ("The Eagle of Durango")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 17661
* Listening on http://192.168.64.4:3000
Use Ctrl-C to stop
```
