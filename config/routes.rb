Rails.application.routes.draw do
  root "homes#index"
  resources :missions

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end