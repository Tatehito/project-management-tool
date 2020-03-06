Rails.application.routes.draw do
  root 'members#login'
  resources :teams
  resources :members
  resources :team_members

  resources :rooms
  
  resources :meetings
  get 'meetings/new/:id', to: 'meetings#new'
  resources :meeting_members
end
