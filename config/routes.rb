require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :calendar_events
  # get '/redirect', to: 'calendar_events#redirect', as: 'redirect'
  namespace :google_console do
    get '/callback', to: 'base#callback', as: 'callback'
  end
  get 'auth/:provider/callback', to: 'auth_sessions#create'
  get 'auth/failure', to: redirect('/')

  resources :auth_sessions
  # resources :sessions, only: [:create, :destroy]
  resources :events
  namespace :admin do
    resources :users
    resources :cards
    resources :programs
    resources :categories
    resources :card_templates
    resources :events

    root to: "users#index"
  end

  resources :cards
  resources :stats
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
