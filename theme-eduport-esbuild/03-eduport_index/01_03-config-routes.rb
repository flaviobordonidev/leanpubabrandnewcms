Rails.application.routes.draw do
  get 'mockups/page_a'
  get 'mockups/edu_index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'mockups#page_a'
end
