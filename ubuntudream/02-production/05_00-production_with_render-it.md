# <a name="top"></a> Cap 2.5 - Prepariamo l'app per la produzione

Before deploying any serious application in production, some minor tweaks are required.



## Risorse interne

-[]()



## Risorse esterne

-[]()



## Go Production-Ready


Open config/database.yml and find the production section. Modify it to gather the database configuration from the DATABASE_URL environment variable:

***code 01 - .../config/database.yml - line:82***

```yaml
production:
  <<: *default
  url: <%= ENV['DATABASE_URL'] %>
```

Open config/puma.rb and uncomment the following lines:

***code 02 - .../config/puma.rb - line:01***

```ruby
# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers ENV.fetch("WEB_CONCURRENCY") { 4 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
preload_app!
```

Open config/environments/production.rb and enable the public file server when the RENDER environment variable is present (which always is on Render):


***code 03 - .../config/environments/production.rb - line:01***

```ruby
# Disable serving static files from the `/public` folder by default since
# Apache or NGINX already handles this.
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || ENV['RENDER'].present?
```



## Create a Build Script
You will need to run a series of commands to build your app. This can be done using a build script. Create a script called bin/render-build.sh at the root of your repository:

***code 04 - .../bin/render-build.sh - line:01***

```bash
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
```

Make sure the script is executable before checking it into Git:

```bash
$ chmod a+x bin/render-build.sh
```

We will configure Render to call this script on every push to the Git repository.

Commit all changes and push them to your GitHub repository. Now your application is ready to be deployed on Render!



## Deploy to Render

There are two ways to deploy your application on Render, either by declaring your services within your repository in a render.yaml file, or by manually setting up your services using the dashboard. In the following steps, we will walk you through both options.

### Use render.yaml to Deploy

Create a file named render.yaml at the root of your directory with the following content. The file will include information about your Rails Web Service and the Database that is used by your application. Don’t forget to commit and push it to your remote repository.

***code 05 - .../render.yaml - line:01***

```yaml
databases:
  - name: mysite
    databaseName: mysite
    user: mysite

services:
  - type: web
    name: mysite
    env: ruby
    buildCommand: "./bin/render-build.sh"
    startCommand: "bundle exec puma -C config/puma.rb"
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: mysite
          property: connectionString
      - key: RAILS_MASTER_KEY
        sync: false
```
