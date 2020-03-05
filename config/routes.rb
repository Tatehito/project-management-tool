Rails.application.routes.draw do
  root 'members#login'
  resources :teams
  resources :members
  get '/team_members/:id', to: 'team_members#show'
  post '/team_members/add', to: 'team_members#create'
end
