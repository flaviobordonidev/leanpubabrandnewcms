Rails.application.routes.draw do

  root 'posts#index'
  resources :posts, :only => [:index, :show]

  devise_for :authors
  namespace :authors do
    resources :posts, :except => [:show]
  end

  get 'test_pages/page_a'
  get 'test_pages/page_b'
  
  #get 'about' => 'pages#about', as: :about
  #get 'contact' => 'pages#contact', as: :contact
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
