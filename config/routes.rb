Rails.application.routes.draw do
  root 'members#login'
  resources :teams
  resources :members
end
