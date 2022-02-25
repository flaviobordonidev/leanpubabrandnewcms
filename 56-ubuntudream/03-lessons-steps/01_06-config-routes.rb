Rails.application.routes.draw do
  resources :steps
  resources :lessons

  root 'lessons#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
