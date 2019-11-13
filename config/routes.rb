Rails.application.routes.draw do
  root 'static_pages#top'
  # static_pages_controller.rbのtopアクションはこれを呼びにきてView（Top.html.erb)を出力しtopページを出している
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
    end
    resources :attendances, only: :update
  end
end
