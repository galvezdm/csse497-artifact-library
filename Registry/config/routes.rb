Registry::Application.routes.draw do

  #resources
  resources :sessions, only: [:new, :create]
  resources :users
  resources :friends, only: [:index, :show]
  resources :collections
  resources :artifact
  #Root
  root to: 'home#home'

  match '/help' => 'static#help'

  match '/about' => 'static#about'

  match '/artifacts' => 'users#artifacts'

  match '/friends' => 'users#friends'

  match '/artifact/create' => 'artifact#create'

  match '/collection/create' => 'collections#create'

  #Get a user's collection IDs
  match 'user/:id/collections', to: 'user#collections'

  #User Pages
  match 'user/collections', to: 'users#collections'
  match 'user/artifacts', to: 'users#artifacts'
  match 'users/:id/edit', to: 'users#edit'
  match 'user/profile/', to: 'users#show'
  match '/signup', to: 'users#create'

  #User sessions and invituation
  match '/invite', to: 'users#validate_invite', via: :post
  match '/sessions', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy'

  #Friends
  match 'friends/collections/:id/:friend_id', to: 'friends#collections'
  match 'friends/artifacts/:id/:friend_id', to: 'friends#artifacts'

  #Collections
  match 'collections/info/:id', to: 'collections#info'
  match 'collections/edit/:id', to: 'collections#edit'

  #Search
  match '/search', to:'search#show'
end
