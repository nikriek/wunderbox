Rails.application.routes.draw do
  devise_for :users, :skip => [:sessions, :registrations, :passwords], :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    delete "/users/logout" => "devise/sessions#destroy"
  end

  post '/order', to: 'order#create'
  get '/congratulations',  to: 'order#congratulations'
  get '/order',  to: 'order#new'
  get '/pricing', to: 'static_pages#pricing'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/login',  to: 'home#login'

  root to: "home#index"
  
end
