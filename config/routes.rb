Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :votable do
    member do
      post :up_vote
      post :down_vote
      delete :revote 
    end
  end

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable do
      patch :accept, on: :member
    end
  end

  resources :attachments, only: [:destroy]
  root to: "questions#index"
end
