Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :cards
    resources :programs

    root to: "users#index"
  end

  resources :cards
  resources :stats
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
