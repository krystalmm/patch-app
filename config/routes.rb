Rails.application.routes.draw do

  devise_for :admin_users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'static_pages#home'

  get '/unsubscribe/:id', to: 'static_pages#unsubscribe', as: 'confirm_unsubscribe'
  patch '/unsubscribe/:id/withdraw', to: 'static_pages#withdraw', as: 'withdraw_user'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users, only: [:edit, :create, :update, :show]

  resources :password_resets, only: [:new, :edit, :create, :update]

  resources :products, only: [:index, :show]

  resources :carts, only: [:show]

  resources :cards, only: [:new, :create, :show, :destroy]

  resources :orders, only: [:new, :create, :index, :show]

  post '/add_item', to: 'carts#add_item'

  post '/update_item', to: 'carts#update_item'

  delete '/delete_item', to: 'carts#delete_item'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end

