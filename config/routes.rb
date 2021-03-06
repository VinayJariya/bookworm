Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 	'/signup',	to: 'users#new'
  post 	'/signup', 	to: 'users#create'

  get 	'/about', 	to: 'static_pages#about'
  get 	'/contact', to: 'static_pages#contact'
  get 	'/help',   	to: 'static_pages#help'

  get 	'/login',   to: 'sessions#new'
  post 	'/login',	  to: 'sessions#create'
  delete'/logout',	to: 'sessions#destroy'

  get   '/books',   to: 'books#index'

  get   '/custom_books/(:id)', to: 'books#custom_books_index', as: 'custom_books'

  get   '/search/(:search)',   to: 'books#search_books', as: 'search_query'

  get   '/otp_verification/(:id)',   to:  'users#otp_verification', as: 'otp_verification'

  post  '/otp_verified', to: 'users#otp_verified'

  root 	'static_pages#home'

  resources :users
  resources :books
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
