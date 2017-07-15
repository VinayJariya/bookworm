Rails.application.routes.draw do

  get 'sessions/new'

  get 	'/signup',	to: 'users#new'
  post 	'/signup', 	to: 'users#create'

  get 	'/about', 	to: 'static_pages#about'
  get 	'/contact', to: 'static_pages#contact'
  get 	'/help', 	to: 'static_pages#help'

  get 	'/login',	to: 'sessions#new'
  post 	'/login',	to: 'sessions#create'
  delete'/logout',	to: 'sessions#destroy'

  root 	'static_pages#home'

  resources :users
end
