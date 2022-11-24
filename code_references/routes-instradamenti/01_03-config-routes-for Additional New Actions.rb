Rails.application.routes.draw do
  # https://guides.rubyonrails.org/routing.html

  resources :lessons do
    resources :steps
  end
  
  resources :company_person_maps
  #2.10.3 Adding Routes for Additional New Actions
  # resources :company_person_maps do
  #   get 'new_person', on: :new
  # end
  # This will enable Rails to recognize paths such as /company_person_maps/new/new_person with GET, and route to the preview action of CompanyPersonMapsController. It will also create the new_person_new_company_person_map_url and new_person_new_company_person_map_path route helpers.
  
  resources :people
  resources :people do
    member do
      delete :delete_image_attachment
    end
  end

  resources :companies do
    member do
      delete :delete_image_attachment
    end
  end
  
  resources :todo_lists
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
  get 'mockups/s2p2_people_index'
  get 'mockups/s2p3_people_new'
  get 'mockups/s3p1_videos_show'
  get 'mockups/s3p2_videos_show'
  get 'mockups/youtube_player'
  get 'pages/home'
  get 'pages/settings'
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
