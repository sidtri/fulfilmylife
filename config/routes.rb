require 'sidekiq/web'

Rails.application.routes.default_url_options[:host] = ENV["default_url_options_host"]

Rails.application.routes.draw do

  get '/redirect', to: 'google_sessions#redirect', as: 'redirect'
  get '/callback', to: 'google_sessions#callback', as: 'callback'
  get '/calendars', to: 'google_sessions#calendars', as: 'calendars'
  get '/events/:calendar_id', to: 'google_sessions#events', as: 'events', calendar_id: /[^\/]+/
  post '/events/:calendar_id', to: 'google_sessions#new_event', as: 'new_event', calendar_id: /[^\/]+/


  resources :new_surveys
  mount Sidekiq::Web => '/sidekiq'

  resources :calendar_events do 
    collection do 
      get :share
    end
  end

  namespace :contests do 
    resources :surveys
    resources :attempts 
  end
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