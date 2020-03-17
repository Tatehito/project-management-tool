Rails.application.routes.draw do
  root 'login#index'
  resources :members
  resources :teams do
    member do
      get :members
    end
  end
  
  resources :meetings, only: [:show, :edit]
end
