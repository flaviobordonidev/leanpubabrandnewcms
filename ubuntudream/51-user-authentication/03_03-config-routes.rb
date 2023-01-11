Rails.application.routes.draw do
  devise_for :users
  resources :users

  get 'mockups/page_a'
  get 'mockups/edu_sign_in'
  get 'mockups/edu_index'
  get 'mockups/edu_student_bookmark'
  get 'mockups/edu_faq'
  get 'mockups/sign_in'
  get 'mockups/homepage'
  get 'mockups/lessons_show'
  get 'mockups/lessons_show_steps_show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'mockups#page_a'
end
