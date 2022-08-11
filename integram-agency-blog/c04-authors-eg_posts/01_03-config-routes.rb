Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  namespace :authors do
    resources :posts, :except => [:show]
  end
  resources :posts, :only => [:index, :show]

  resources :eg_companies
  resources :eg_posts
  resources :eg_users
  
  #get 'users/index', as: :user_root #creates user_root_path (default path after sign_in)
  #get 'users/show', as: :user_root #creates user_root_path (default path after sign_in)
  #get 'eg_posts', to:'eg_posts#index', as: :user_root #creates user_root_path (default path after sign_in)
  #get 'sections' => 'mockups#page_b'
  #get 'authors' => 'mockups#page_c'
  get 'mockups/page_a'
  get 'mockups/page_b'
  get 'mockups/page_c'
  get 'mockups/login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
