Rails.application.routes.draw do
  root "homes#index"
  resources :missions do
    collection do
      get 'search', to: 'missions#search'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end