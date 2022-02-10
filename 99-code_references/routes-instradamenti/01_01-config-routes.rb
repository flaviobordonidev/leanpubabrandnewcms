Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  resources :eg_posts
  resources :eg_users

  get 'sections' => 'mockups#page_a' # Creiamo un link secions_path che è reinstradato su mockups/page_a
  get 'signatures' => 'mockups#page_b'
  get 'mockups/page_a'
  get 'mockups/page_b'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
