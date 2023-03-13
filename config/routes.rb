Rails.application.routes.draw do

  # 会員側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    resources :users, only: [:destroy]
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
    # ↓ ユーザーに関するページのルーティング
    get "users/my_page" => "users#show"
    get "users/my_post" => "users#index"
    get "users/information/edit" => "users#edit"
    patch "users/information" => "users#update"
    get "users/like" => "users#like"  # ユーザがブックマークした投稿の一覧
    get "users/quit" => "users#quit"  # ユーザーの退会確認画面

  end



  # 管理側
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :tags, only: [:create, :index, :update, :destroy]
    resources :users, only: [:show, :index, :destroy]
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    get "comments" => "comments#index"  #管理側のコメント一覧ページ
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
