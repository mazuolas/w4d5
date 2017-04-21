Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :show] do
    resources :goals
  end
end
