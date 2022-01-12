
Debugging Rails in Development


Risorse esterne:

* https://gist.github.com/philsmy/e5de9b16279300f30ae8a6286ce05fdb
* https://www.youtube.com/watch?v=MJSZ3WcgHeE
* https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem

This is the companion to my YouTube video: https://youtu.be/MJSZ3WcgHeE

Debugging Rails in Development

1. Basic
https://guides.rubyonrails.org/debugging_rails_applications.html

Putting debug info into views using debug helper (or to_yaml or inspect)
<% if Rails.env.development? %>
    <div class='row'>
    <div class='col'>
    <%= time_tracker %>
    </div>
    </div>
  <% end %>
Logging! logger.(debug|info|warn|error|fatal|unknown) (https://scoutapm.com/blog/debugging-with-rails-logger)
Extra log files
logfile = File.open(Rails.root.join('log/order_task_logger.log'), 'a') # create log file
logfile.sync = true # automatically flushes data to file
TASKS_LOGGER = Logger.new(logfile) # constant accessible anywhere
TASKS_LOGGER.level = Rails.env.development? ? Logger::DEBUG : Logger::WARN


2. Intermediate (gems)
marginalia gem to add info into SQL comments - LOVE THIS - https://github.com/basecamp/marginalia
add Marginalia::Comment.components = [:line] in config/initializers/marginalia.rb
2a. Memory Gems
Not my area of expertise!

memory_profiler gem (who is using what) (https://github.com/SamSaffron/memory_profiler)
derailed_benchmarks (memory leaks, etc) (https://github.com/zombocom/derailed_benchmarks)
stackprof memory profiling (https://github.com/tmm1/stackprof)
TIP: To run production on your machine with postgres change the database.yml

3. Low Level
byebug (https://github.com/deivid-rodriguez/byebug)
https://blog.usejournal.com/why-byebug-will-be-your-best-friend-when-programming-in-rails-98e06f46bdb6
web_console (https://github.com/rails/web-console)
https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-web-console-gem
config.web_console.whitelisted_ips = ['2405:6583:e80:2200:29f9:5c2f:71d9:b238', '::/0']

##4. VSCode

https://lankydan.dev/2017/05/12/debugging-a-rails-server-in-visual-studio-code
install gems
configure Spring <- makes me nervous!
run