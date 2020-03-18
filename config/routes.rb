Rails.application.routes.draw do
  root 'login#index'
  resources :members
  resources :teams do
    member do
      get :members
      delete :member, to: 'teams#destroy_member'
      post :member, to: 'teams#add_member'
    end
    resources :meetings
  end
  resources :meetings
  resources :rooms
end
