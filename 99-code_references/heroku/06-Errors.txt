# Errors




## IP address mismatch

* https://stackoverflow.com/questions/63363085/ip-address-mismatch-on-signing-into-heroku-cli

Cercando di fare login mi presenta errore di "IP address mismatch"

Risolto con 

{caption: "terminal", format: bash, line-numbers: false}
```
$ heroku login -i

user_fb:~/environment/rebisworld (mh) $ heroku login -i
heroku: Enter your login credentials
Email [flavio.bordoni.dev@gmail.com]: 
Password: ********
Logged in as flavio.bordoni.dev@gmail.com
```

L'opzione "-i" ci fa fare login direttamente da terminale senza passare per l'interfaccia grafica web.

