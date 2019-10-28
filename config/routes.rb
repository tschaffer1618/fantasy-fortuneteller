Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'


  get '/auth/:provider/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'auth/failure', to: redirect('/')

  namespace :user do
    resources :teams do
      resources :team_players, only: [:new, :create, :destroy]
    end
  end

  get '/players/search', to: 'players#search'

  get '/leaguestats', to: 'stats#index'

  resources :players, only: [:index, :show]

  get '/profile', to: 'users#show'

  resources :users, only: [:edit, :update]

  get '/verification/:user_id', to: 'users#verify'
end
