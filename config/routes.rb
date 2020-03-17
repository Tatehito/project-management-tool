Rails.application.routes.draw do
  root 'login#index'
  resources :members
  resources :teams do
    member do
      get :members
      delete :member, to: 'teams#destroy_member'
    end
  end
  
  resources :meetings, only: [:show, :edit]
end
