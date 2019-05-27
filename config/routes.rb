Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'public/pages#top'

  namespace :admin do
  end

  scope module: :public do

  end

  namespace :api, {format: 'json'} do

  end
end
