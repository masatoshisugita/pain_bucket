Rails.application.routes.draw do

  get '/' => 'pages#index'
  get 'pages/about'

  get 'posts/index'
  get 'users/new'

  get 'users/index'

  get 'users/login_form'
  post 'users/login'
  post 'users/logout'
  post 'users/create'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'

  get 'posts/index'
  get 'posts/new'
  post 'posts/create'
  get 'posts/search'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/delete' => 'posts#delete'

  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'
  get 'users/:id/likes' => 'users#likes'

  get 'users/:id/following' => 'users#following'
  get 'users/:id/followers' => 'users#followers'

  resources :relationships, only: [:create, :destroy]

  resources :messages, :only => [:create]

  get 'rooms/show'
  resources :rooms, :only => [:create, :show]

  resources :posts do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
