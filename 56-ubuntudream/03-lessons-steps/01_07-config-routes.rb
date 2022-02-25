Rails.application.routes.draw do
  resources :lessons do
    resources :steps
  end
  root 'lessons#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end