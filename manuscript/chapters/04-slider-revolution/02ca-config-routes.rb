Rails.application.routes.draw do

  # sudo service postgresql start
  # rails s -b $IP -p $PORT
  
  get 'page_thank_you/show'

  #mount ImageUploader::UploadEndpoint => "/images/upload"
  #mount Shrine.presign_endpoint(:cache) => "/presign"
  
  #root 'posts#index'
  root 'homepage#show'

  resources :posts, :only => [:index, :show]
  get 'authors_index' => 'posts#authors_index'
  get 'index2' => 'posts#index2'
  get 'index3' => 'posts#index3'
  get 'index4' => 'posts#index4'
  get 'index5' => 'posts#index5'
  get 'index6' => 'posts#index6'
  get 'index7' => 'posts#index7'

  devise_for :authors
  namespace :authors do
    resources :posts, :except => [:show] do
      put 'publish' => 'posts#publish', on: :member
      put 'unpublish' => 'posts#unpublish', on: :member
    end
    #get '/account' => 'accounts#edit', as: :account
    get '/account' => 'accounts#edit'
    put '/info' => 'accounts#update_info'
    put '/change_password' => 'accounts#change_password'
  end

  get 'homepage/show'
  #get "homepage/", to: "homepage#show"
  #get 'about' => 'pages#about', as: :about
  #get 'contact' => 'pages#contact', as: :contact
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'page_thank_you/show'
  get 'page_story/show'
  get 'privacy/show'
  get 'test_pages/page_a'
  get 'test_pages/page_b'
  get 'test_pages/slider'
  get 'the_game/show'
  get 'why_play/show'
  get 'why_works/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
