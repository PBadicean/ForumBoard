Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :votable do
    member do
      post :up_vote
      post :down_vote
      delete :revote
    end
  end

  concern :commentable do
    resources :comments, only: [:create]
  end

  resources :questions, concerns: %i[votable commentable] do
    resources :answers, concerns: %i[votable commentable], shallow: true do
      patch :accept, on: :member
    end
    resources :subscriptions, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :profiles do
        get :me, on: :collection
      end
      resources :questions do
        resources :answers
      end
    end
  end
  resources :searches

  resources :attachments, only: [:destroy]
  root "questions#index"

  mount ActionCable.server => '/cable'

  match '/users/:id/finish_sign_up', to: 'users#finish_signup', via: [:get, :patch], as: :finish_signup
end
