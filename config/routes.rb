Rails.application.routes.draw do
  root :to => 'static_pages#top'
  resources :users, only: %i[new create]
  resources :boards, only: %i[index]
  
  # resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/login' , to: 'user_sessions#new',  :as => :login
  post '/login' , to: 'user_sessions#create'
  delete '/logout' , to: 'user_sessions#destroy', :as => :logout
end
