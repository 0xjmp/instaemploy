require 'sidekiq/web'

Rails.application.routes.draw do
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'welcome#index'

  #### Devise ####
  devise_for :users, skip: [:sessions, :registrations, :passwords]

  get '/auth/:provider/callback', to: 'omniauth_callbacks#create'

  #### API ####
  namespace :api, constraints: {format: 'json'} do
    namespace :v1 do
      namespace :users do
        devise_scope :user do
          post 'sign_in', to: 'sessions#create'
          delete 'sign_out', to: 'sessions#destroy'
          post '', to: 'registrations#create'
          delete '', to: 'registrations#destroy'
        end

        resources :invitations, only: [:create, :update, :destroy, :show] do
          post 'accept', to: 'invitations#accept'
        end
      end
      resources :users, only: [:index, :show, :update]

      resources :projects, except: [:new] do
        put 'follow', to: 'projects#follow'
        delete 'follow', to: 'projects#unfollow'

        put 'next', to: 'bids#next'
        put 'cancel', to: 'bids#cancel'
      end

      get 'explore', to: 'explore#index'

      get 'search/*query', to: 'search#show'

      get 'skills/*name', to: 'skills#show'
      scope :skills do
        resources :alerts, only: [:create, :destroy]
      end
    end
  end

  get '*path', to: 'application#index'
end
