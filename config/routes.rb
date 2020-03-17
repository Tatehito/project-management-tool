Rails.application.routes.draw do
  root 'login#index'
  resources :members
  resources :teams
  resources :meetings, only: [:show, :edit]
end
