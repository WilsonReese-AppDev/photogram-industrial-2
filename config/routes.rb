Rails.application.routes.draw do
  root "photos#index"

  
  devise_for :users
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  # resources :users, only: :show

  get ":username/liked" => "photos#liked", as: :liked_photos
  get ":username/feed" => "users#feed", as: :feed
  get ":username/followers" => "users#followers", as: :followers
  # get ":username/following" => "photos#liked", as: :liked_photos

  get ":username" => "users#show", as: :user #must be last route
end
