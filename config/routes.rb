Rails.application.routes.draw do

  get 'public/tags'
  # ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # 会員側
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get "no_page" => "homes#error"
    resources :users, only: [:destroy] do
      get "my_page" => "users#index"
      get "information/edit" => "users#edit"
      patch "information" => "users#update"
      get "like"  # ユーザがブックマークした投稿の一覧
      get "quit"  # ユーザーの退会確認画面
    end
    resources :posts do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
    post "tags" => "tags#create"



  end



  # 管理側
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :tags, only: [:create, :index, :update, :destroy]
    resources :users, only: [:show, :index, :update, :destroy]
    resources :posts, only: [:index, :show, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    get "comments" => "comments#index"  #管理側のコメント一覧ページ
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
