Rails.application.routes.draw do

  root 'homepage#show'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  namespace :authors do
    resources :posts, :except => [:show]
  end
  resources :posts, :only => [:index, :show]

  resources :example_companies
  resources :example_posts
  resources :example_users
  
  get 'example_static_pages/page_a'
  get 'example_static_pages/page_b'
  get 'example_static_pages/page_c'
  get 'example_static_pages/slider'
  get 'example_static_pages/posts_index'
  get 'example_static_pages/posts_show'
  get 'homepage/show'
  get 'sections' => 'example_static_pages#page_a'
  get 'signatures' => 'example_static_pages#page_b'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
