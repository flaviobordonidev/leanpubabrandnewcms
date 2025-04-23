# <a name="top"></a> Test

Test



***Codice 01 - .../Gemfile - linea:65***

```diff
-code to remove
+code to add
```

Esempi:

```diff
# app/views/layouts/application.html.erb
<body>
+  <%= link_to 'Home', root_path %>
+  <%= link_to 'Dashboard', dashboard_path %>
+  <% if authenticated? %>
+    <%= Current.user.email_address %>
+    <%= button_to 'Sign out', session_path, method: :delete %>
+  <% else %>
+    <%= link_to 'Sign in', new_session_path %>
+  <% end %>
+  <hr>
  <main class="container mx-auto mt-28 px-5 flex flex-col">
    <%= yield %>
  </main>
</body>
```

```diff
-class StateController < ApplicationController
+class SessionsController < ApplicationController
  allow_unauthenticated_access
```

```diff
# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
-  allow_unauthenticated_access
+  allow_unauthenticated_access(only: %i[new create])
```

```diff
# app/controllers/concerns/authentication.rb
  def request_authentication
    session[:return_to_after_authenticating] = request.url
-   redirect_to new_session_url
+   redirect_to new_session_url, alert: "Authenticate to access this page."
  end
```
