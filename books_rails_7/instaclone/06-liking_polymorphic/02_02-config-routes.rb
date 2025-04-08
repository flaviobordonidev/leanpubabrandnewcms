Rails.application.routes.draw do
  #get 'posts/new'
  #post 'posts/create', as: :posts
  resources :posts, only: [:create, :new] do
    resources :comments, only: [:create, :new]
    resources :likes, only: :create do
      collection do
        delete :destroy
      end
    end
  end

  get "site/first"
  get "site/second"
  post "site/third"
  get "site/fourth"

  #get "/first", to: "site#first", as: :first_page
  #get "/second", to: "site#second", as: :second_page
  #post "/third", to: "site#third", as: :third_page
  #get "/fourth", to: "site#fourth", as: :fourth_page

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "site#index"

end
