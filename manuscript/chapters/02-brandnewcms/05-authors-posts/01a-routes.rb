Rails.application.routes.draw do
  
  #root 'test_pages#page_a'
  root 'posts#index'
  
  #devise_for :users, path: '', path_names: { sign_in: 'login'}
  devise_for :users, controllers: {sessions: 'users/sessions'}, path: '', path_names: {sign_in: 'login'}
  resources :users

  resources :example_posts

  namespace :authors do
    resources :posts
  end
  resources :posts

  #get 'users/show', as: :user_root #creates user_root_path (default path after sign_in)
  get 'example_posts', to:'example_posts#index', as: :user_root #creates user_root_path (default path after sign_in)
  get 'sections' => 'test_pages#page_b'
  get 'authors' => 'test_pages#page_c'
  get 'test_pages/page_a'
  get 'test_pages/page_b'
  get 'test_pages/page_c'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
