Rails.application.routes.draw do
  root 'members#login'
  resources :teams
  resources :members
  resources :team_members

  resources :rooms
  
  resources :meetings
  resources :meeting_members
end
