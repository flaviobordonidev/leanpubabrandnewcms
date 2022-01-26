Aggiornamento Heroku Toolbelt su Cloud9 (fonte 2 {\field{\*\fldinst{HYPERLINK "https://community.c9.io/t/how-to-update-heroku-cli/12074/10"}}{\fldrslt https://community.c9.io/t/how-to-update-heroku-cli/12074/10}})\
(fonte 1 {\field{\*\fldinst{HYPERLINK "https://stackoverflow.com/questions/45212677/how-can-i-specify-herokus-mime-type?rq=1"}}{\fldrslt https://stackoverflow.com/questions/45212677/how-can-i-specify-herokus-mime-type?rq=1}} )\
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh\cf4 \strokec4 \
\pard\pardeftab720\sl300\partightenfactor0


link referral: {\field{\*\fldinst{HYPERLINK "https://devcenter.heroku.com/articles/upgrading-heroku-postgres-databases#upgrading-with-pg-copy"}}{\fldrslt https://devcenter.heroku.com/articles/upgrading-heroku-postgres-databases#upgrading-with-pg-copy}}\

bobdesa64:~/workspace $ cd donamat\
RVM used your Gemfile for selecting Ruby, it is all fine - Heroku does that too,\
you can ignore these warnings with 'rvm rvmrc warning ignore /home/ubuntu/workspace/donamat/Gemfile'.\
To ignore the warning for all files run 'rvm rvmrc warning ignore allGemfiles'.\
\
bobdesa64:~/workspace/donamat (kd) $ heroku pg:info\
=== DATABASE_URL\
Plan:                  Hobby-dev\
Status:                Available\
Connections:           0/20\
PG Version:            9.5.12\
Created:               2016-10-01 09:38 UTC\
Data Size:             10.0 MB\
Tables:                6\
Rows:                  9528/10000 (In compliance, close to row limit)\
Fork/Follow:           Unsupported\
Rollback:              Unsupported\
Continuous Protection: Off\
Add-on:                postgresql-animate-41780\
\
bobdesa64:~/workspace/donamat (kd) $ heroku addons:create heroku-postgresql:hobby-basic                                                   \
Creating heroku-postgresql:hobby-basic on 
\f2 \uc0\u11042 
\f1  limitless-chamber-62677... $9/month\
Created postgresql-infinite-70761 as HEROKU_POSTGRESQL_COBALT_URL\
Database has been created and is available\
 ! This database is empty. If upgrading, you can transfer\
 ! data from another database with pg:copy\
Use heroku addons:docs heroku-postgresql to view documentation\
bobdesa64:~/workspace/donamat (kd) $ heroku pg:info\
=== DATABASE_URL\
Plan:                  Hobby-dev\
Status:                Available\
Connections:           1/20\
PG Version:            9.5.12\
Created:               2016-10-01 09:38 UTC\
Data Size:             10.0 MB\
Tables:                6\
Rows:                  9528/10000 (In compliance, close to row limit)\
Fork/Follow:           Unsupported\
Rollback:              Unsupported\
Continuous Protection: Off\
Add-on:                postgresql-animate-41780\
\
=== HEROKU_POSTGRESQL_COBALT_URL\
Plan:                  Hobby-basic\
Status:                Available\
Connections:           0/20\
PG Version:            10.3\
Created:               2018-04-20 21:48 UTC\
Data Size:             7.6 MB\
Tables:                0\
Rows:                  0/10000000 (In compliance)\
Fork/Follow:           Unsupported\
Rollback:              Unsupported\
Continuous Protection: Off\
Add-on:                postgresql-infinite-70761\

bobdesa64:~/workspace/donamat (kd) $ heroku pg:wait\
bobdesa64:~/workspace/donamat (kd) $ heroku pg:copy DATABASE_URL HEROKU_POSTGRESQL_COBALT\


heroku pf:promote HEROKU_POSTGRESQL_PINK\
heroku addons:destroy HEROKU_POSTGRESQL_LAVENDER\
}