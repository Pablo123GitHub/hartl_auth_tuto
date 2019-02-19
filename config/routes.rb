Rails.application.routes.draw do
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'signup', to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  post 'signup', to: 'users#create'

  resources :users
  
end
