Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions do
    resources :answers do
      patch :accept, on: :member
    end
    post :vote_for, on: :member 
  end

  resources :attachments, only: [:destroy]
  root to: "questions#index"
end
