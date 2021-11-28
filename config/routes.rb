Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 開発環境でメーラーを確認
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  root 'top_page#top'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resource :profile, only: %i[show edit update]

  resources :campsites, only: %i[index show] do
    collection do
      get :mypage
    end
  end
  resources :bookmarks, only: %i[create destroy]

  resources :password_resets, only: %i[new create edit update]

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
end
