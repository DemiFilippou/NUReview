Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :update]
  resources :tags, only: [:index]


  resources :companies do
    resources :reviews, only: [:create, :update, :index] 
  end

  post 'login', to: 'users#login'
  get '/search', to: 'companies#search'
end

