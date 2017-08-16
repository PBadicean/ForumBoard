Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :votable do
    post :up_vote, on: :member
    post :down_vote, on: :member
    delete :revote, on: :member
  end

  resources :questions, concerns: :votable do
    resources :answers, concerns: :votable do
      patch :accept, on: :member
    end
  end

  resources :attachments, only: [:destroy]
  root to: "questions#index"
end
