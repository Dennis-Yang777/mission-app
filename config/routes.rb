Rails.application.routes.draw do
  root "missions#index"
  resources :missions

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end