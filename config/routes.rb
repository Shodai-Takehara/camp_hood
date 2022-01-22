Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 開発環境でメーラーを確認
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'top_page#top'
  get 'terms_of_service', to: 'top_page#terms_of_service'
  get 'privacy_policy', to: 'top_page#privacy_policy'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create destroy]
  resource :profile, only: %i[edit update]

  resources :campsites, only: %i[index show guidance] do
    collection do
      get :mypage
    end
    member do
      get :guidance
    end
    resources :reviews, only: %i[index create destroy]
  end
  resources :bookmarks, only: %i[create destroy]

  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index show edit update destroy]
    resources :campsites
  end

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
