# Su Rails Console visulalizzare records stile Yaml

Rails 3

{title="terminal", lang=bash, line-numbers=off}
~~~~~~~~
$ rails c

# Rails 3
irb> y Company.all

# Rails 4
irb> puts Company.all.to_yaml
~~~~~~~~
