Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :cards

    root to: "users#index"
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
