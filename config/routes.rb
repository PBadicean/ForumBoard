Rails.application.routes.draw do
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
  end

  resources :attachments, only: [:destroy]
  root to: "questions#index"

  mount ActionCable.server => '/cable'

  match '/users/:id/finish_sign_up', to: 'users#finish_sign_up', via: [:get, :patch], as: :finish_sign_up
end
