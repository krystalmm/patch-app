Rails.application.routes.draw do

  namespace :admins do
    get 'toppages/index'
  end
  get 'products/index'
  get 'products/show'
  root 'static_pages#home'

  get '/support', to: 'static_pages#support'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/unsubscribe/:id', to: 'static_pages#unsubscribe', as: 'confirm_unsubscribe'
  patch '/unsubscribe/:id/withdraw', to: 'static_pages#withdraw', as: 'withdraw_user'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:new, :edit, :create, :update, :show]

  resources :password_resets, only: [:new, :edit, :create, :update]

  namespace :admins do
    root 'toppages#index'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

