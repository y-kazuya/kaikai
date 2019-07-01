Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'public/pages#top'

  namespace :admin do
  end

  scope module: :public do

    get    '/accounts',    to: 'accounts#new'
    resources :accounts, except: [:index] do
      member do
        get :dashboard
      end
      resource :facilities, only: [:show,:update]
      resources :users, only: [:index,:new,:create,:show,:update,:destroy]

    end



    resources :sessions, only: [:new, :create, :destroy]
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :api, {format: 'json'} do
    post    "/login",                    to: "sessions#new"
    post   "/signup",                   to: "sessions#create"

    get    "/user_counts",                    to: "user_counts#index"
    get    "/note_categories",               to: "note_categories#index"
    get    "/user_counts",                    to: "user_counts#index"
    post   "/create_note_category",         to: "note_categories#create"
    post   "/create_check",         to: "checks#create"

    post   "/irregular_visits",         to: "irregular_visits#create"
    delete "/irregular_visits",         to: "irregular_visits#destroy"
  end
end
