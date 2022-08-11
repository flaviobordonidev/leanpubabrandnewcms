Rails.application.routes.draw do

  root 'pages#home'

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
  get 'mockups/blog_post_layout_05'
  get 'mockups/bactosense_home'
  get 'mockups/login'
  get 'mockups/page_a'
  get 'mockups/page_b'
  get 'mockups/s1p0_work_in_progress'
  get 'mockups/s1p1_home'
  get 'mockups/s1p2_company_index'
  get 'mockups/s1p3_company_new'
  get 'mockups/s1p4_company_index'
  get 'mockups/s1p5_company_person_index'
  get 'pages/home'
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
