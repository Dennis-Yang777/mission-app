Rails.application.routes.draw do
  root "homes#index"
  resources :missions, except: [:show] do
    collection do
      get 'search', to: 'missions#search'
      get 'state_search', to: 'missions#state_search'
      get 'priority_search', to: 'missions#priority_search'
    end
    member do
      post 'run', to: 'missions#change_state'
    end
  end

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: 'users/sessions'
  }
end