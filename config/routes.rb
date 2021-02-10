Rails.application.routes.draw do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

