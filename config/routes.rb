Rails.application.routes.draw do
  devise_for :users, skip: [:registrations], controllers: {
    sessions: "users/sessions"
  }

  root to: "dashboard#index"

  resources :blocks, only: [:index, :new, :create, :show, :destroy]
  resources :units, only: [:show] do
    resources :unit_users, only: [:create, :destroy]
  end
  resources :ticket_types, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :ticket_statuses, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :tickets, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create]
    resources :attachments, only: [:create, :destroy]
    member do
      patch :update_status
    end
  end

  resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end