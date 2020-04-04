Rails.application.routes.draw do
  root 'home#top'

  get 'home/about' => "home#about"
  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end
  #resources :book_comments, only:[:destroy]
  resources :users,only: [:new, :create, :show, :index, :edit,:update]

end