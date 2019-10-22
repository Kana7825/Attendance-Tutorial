Rails.application.routes.draw do
  root 'static_pages#top'# static_pages_controller.rbのtpoアクションはこれを呼びにきてView（Top.html.erb)を出力しtopページを出している
  get '/signup', to: 'users#new'
  resources :users
end
