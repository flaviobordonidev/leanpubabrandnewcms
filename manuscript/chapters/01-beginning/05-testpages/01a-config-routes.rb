Rails.application.routes.draw do

  root 'test_pages#page_a'
  get 'test_pages/page_a'
  get 'test_pages/page_b'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
