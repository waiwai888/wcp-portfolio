Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get '/search', to: 'searches#search'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    delete 'notifications/destroy_all', to: 'notifications#destroy_all'
    resources :notifications, only: [:index, :create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  get 'posts/followed_index', to: 'posts#followed_index'
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :chats, only: [:show, :create]
  resources :tags do
    get 'search', to: 'posts#search'
  end

  resources :camp_sites, only: [:new, :create, :destroy, :index, :show]
  post 'camp_sites/:camp_site_id', to: 'reviews#create' , as: 'camp_site_reviews'
  delete 'camp_sites/:camp_site_id/:id', to: 'reviews#destroy' , as: 'camp_site_review'

end
