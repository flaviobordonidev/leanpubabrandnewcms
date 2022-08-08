Rails.application.routes.draw do
  get "site/first"
  post "site/second"
  post "site/third"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "site#first"
end
