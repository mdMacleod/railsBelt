Rails.application.routes.draw do

  root 'users#new'
  get '/users', to: 'users#new'
  post '/users', to: 'users#create'
  post '/login', to: 'sessions#create', as: 'login_user'
  

  get '/groups', to: 'groups#new'
  post '/groups', to: 'groups#create'
  delete '/groups', to: 'groups#delete', as: 'delete_group'

  get '/groups/show', to: 'groups#show', as: 'groups_show'
  

  post '/members', to: 'members#create', as: 'join_group'
  delete 'members', to: 'members#destroy', as: 'leave_group'


  delete '/logout', to: 'sessions#logout', as: 'log_out'

  match '*path' => redirect('/users'), via: :get
  
end
