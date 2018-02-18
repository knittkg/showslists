Rails.application.routes.draw do
  resources :artists
  resources :sessions, only: [:new, :create, :destroy]
  resources :showslists do
    get :download, :on => :collection
    end
    if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
  resources :users, only: [:new, :create, :show]
end
