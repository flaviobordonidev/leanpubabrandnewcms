## Ruby Playtime

Here’s some stuff to try on your own. Experiment with the following expressions:

Addition: <%= 1+2 %>

Concatenation: <%= "cow" + "boy" %>

Time in one hour: <%= 1.hour.from_now %>

A call to the following Ruby method returns a list of all the files in the current directory:

 	@files = Dir.glob('*')
Use it to set an instance variable in a controller action, and then write the corresponding template that displays the filenames in a list on the browser.

Hint: you can iterate over a collection using something like this:

 	<% for file in @files %>
 	file name is: <%= file %>
 	<% end %>
You might want to use a <ul> for the list.

(You’ll find hints at http://www.pragprog.com/wikis/wiki/RailsPlayTime.)

