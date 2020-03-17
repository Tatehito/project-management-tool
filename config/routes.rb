Rails.application.routes.draw do
  root 'login#index'
  resources :members
  resources :teams
end
