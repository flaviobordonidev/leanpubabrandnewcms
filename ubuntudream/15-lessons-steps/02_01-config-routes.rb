Rails.application.routes.draw do
  resources :steps
  resources :lessons

  namespace :authors do
    resources :eg_posts, :except => [:show] do
      member do
        delete :delete_image_attachment
      end
    end
  end
  resources :eg_posts, :only => [:index, :show] 

  resources :eg_users
  get 'users/index'
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: { sessions: 'users/sessions' }
  resources :users

  get 'mockups/page_a'
  get 'mockups/page_b'
  get 'mockups/bs_grid'
  get 'mockups/bs_gutter'
  get 'mockups/bs_buttons'
  get 'mockups/bs_cards_and_panels'
  get 'mockups/bs_images'
  get 'mockups/bs_icons'
  get 'mockups/bs_theming_kit'
  get 'mockups/bs_ud_home'
  get 'mockups/bs_ud_news'
  get 'mockups/bs_ud_tema'
  get 'mockups/edu_index_4'
  get 'mockups/edu_ud_list'
  get 'mockups/stimulus_demo'
  #get 'eg_posts', to:'eg_posts#index', as: :user_root #creates user_root_path (default path after sign_in)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'mockups#page_a'
end
