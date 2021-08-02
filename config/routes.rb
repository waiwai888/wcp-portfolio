Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get '/search', to: 'searches#search'
  get 'relationships/create'
  get 'relationships/destroy'

  resources :users, only: [:edit, :update]do
    resources :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  
  resources :posts, only: [:new, :create, :index, :show, :edit, :update]do
    resources :post_comments, only: [:create, :destroy]
    resources :notifications, only: [:create, :destroy, :all_destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :chats, only: [:show, :create]

end
