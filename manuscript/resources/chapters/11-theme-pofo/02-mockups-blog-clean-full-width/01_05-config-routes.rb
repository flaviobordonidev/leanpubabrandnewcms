Rails.application.routes.draw do

  root 'mockups#page_a'

  devise_for :users, path_names: {sign_in: 'login'}, path: '', controllers: { sessions: 'users/sessions' }
  resources :users

  resources :eg_components
  resources :eg_companies
  namespace :authors do
    resources :eg_posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
  resources :eg_posts, :only => [:index, :show]
  resources :eg_users

  #get 'eg_posts', to:'eg_posts#index', as: :user_root #creates user_root_path (default path after sign_in)
  get 'mockups/blog_clean_full_width'
  get 'mockups/login'
  get 'mockups/page_a'
  get 'mockups/page_b'
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
