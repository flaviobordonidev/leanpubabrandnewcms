Rails.application.routes.draw do

  root 'example_static_pages#page_a'
  
  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users  
  
  get 'example_static_pages/page_a'
  get 'example_static_pages/page_b'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end