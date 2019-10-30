Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'auth/failure', to: redirect('/')

  namespace :admin do
    resources :users, only: [:index, :destroy]
  end

  namespace :user do
    resources :teams do
      resources :team_players, only: [:destroy, :create]
    end
  end

  get '/leaguestats', to: 'stats#index'

  resources :players, only: [:index, :show]
  get '/players/search', to: 'players#search'

  resources :users, only: [:edit, :update]
  get '/profile', to: 'users#show'
  get '/verification/:user_id', to: 'users#verify'

  match "*path", to: "home#catch_404", via: :all
end
