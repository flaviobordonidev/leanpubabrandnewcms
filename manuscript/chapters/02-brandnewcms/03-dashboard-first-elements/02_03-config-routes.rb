Rails.application.routes.draw do

  root 'example_static_pages#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  resources :posts

  resources :example_companies
  resources :example_posts
  resources :example_users
  
  get 'sections' => 'example_static_pages#page_a'
  get 'signatures' => 'example_static_pages#page_b'
  get 'example_static_pages/page_a'
  get 'example_static_pages/page_b'
  get 'example_static_pages/page_c'
  get 'example_static_pages/slider'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
