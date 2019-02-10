Rails.application.routes.draw do

  devise_for :users, :skip => [:registration]

  root to: 'home#index'

  resources :users do
    get 'developer_stats' => "todos#developer_stats"
    get 'project_stats' => "todos#project_stats"

    resources :projects do
      resources :todos
    end
  end

end
