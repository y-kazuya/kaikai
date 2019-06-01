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

    end



    resources :sessions, only: [:new, :create, :destroy]
  end

  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :api, {format: 'json'} do

  end
end
