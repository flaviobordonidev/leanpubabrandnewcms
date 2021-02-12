
## Se clicco il check_box mi appare il selettore di date.

(lo potrei usare per far apparire le stelline di rating solo se è un cliente o un fornitore)

in default mode the checkbox is unchecked and the datetime field is hidden when the user marks (clicks) the checkbox (so it is checked) the datetime field is shown
This is what I have in my view (very close to it):

<% form_for(logentry, :url => @url, :method => @method) do |f| %>
<%= f.error_messages %>

[...]
<%= f.label :mycheckbox, "Remind me?" %>	<%= f.check_box :mycheckbox %>
<%= f.label :remind_when, "Date"%>	<%= datetime_select "logentry","remind_when", :default => Time.now %>
<%= f.submit submit_name %>

<% end %>


I’ve found a solution. I have created a simple javascript:

my checkbox in the form has
:id => “thiselement”, :onchange => “switchvisibility(‘thiselement’)”

and the table row I want do hide has:

....


That’s fine, but Rails normally includes the prototype libs, so you
could have done it in one line:

:onclick => “ELEMENT_NAME.hide();return false”