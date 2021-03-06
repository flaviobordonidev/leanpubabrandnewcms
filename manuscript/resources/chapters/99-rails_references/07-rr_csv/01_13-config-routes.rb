Rails.application.routes.draw do
  resources :surveys
  resources :transactions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'import', :to => 'transactions#import'

end
