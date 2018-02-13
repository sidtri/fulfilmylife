Rails.application.routes.draw do
  resources :events
  namespace :admin do
    resources :users
    resources :cards
    resources :programs
    resources :categories

    root to: "users#index"
  end

  resources :cards
  resources :stats
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
