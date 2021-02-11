Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
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

  resources :users

  resources :password_resets, only: [:new, :edit, :create, :update]
end

