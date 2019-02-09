Rails.application.routes.draw do

  devise_for :users, :skip => [:registration]

  root to: 'home#index'

  resources :users do
    resources :projects do
      resources :todos
    end
  end

end
