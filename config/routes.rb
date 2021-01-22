Rails.application.routes.draw do
  get '/signup', to: 'users#new'
  root 'static_pages#home'
  get '/support', to: 'static_pages#support'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
