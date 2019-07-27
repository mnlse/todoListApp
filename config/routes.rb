Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'todo_lists/index'
    end
  end
  get 'pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :todo_lists do
        resources :todo_items
      end
    end
  end
end
