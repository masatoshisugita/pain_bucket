Rails.application.routes.draw do

  root to: "pages#index"

  get 'pages/about'
  get 'posts/index'
  get 'posts/new'
  post 'posts/create'
  get 'posts/search'
  get 'posts/search_symptom'

  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/delete' => 'posts#delete'

  post 'likes/:post_id/create' => 'likes#create'
  post '/likes/:post_id/destroy' => 'likes#destroy'
  get 'admin/users/:id/likes' => 'admin/users#likes'

  get 'admin/users/:id/following' => 'admin/users#following'
  get 'admin/users/:id/followers' => 'admin/users#followers'

  resources :relationships, only: [:create, :destroy]

  resources :messages, :only => [:create]

  get 'rooms/show'
  resources :rooms, :only => [:create, :show]

  resources :posts do
    resources :comments
  end

 #adimnルート
  namespace :admin do
    resources :users
  end

  get '/login',to: 'sessions#new'
  post 'login',to: 'sessions#create'
  delete '/logout',to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
