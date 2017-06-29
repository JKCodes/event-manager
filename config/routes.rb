Rails.application.routes.draw do
  get 'welcome/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'

  get '/signin' => "sessions#new"
  post '/sessions/create' => 'sessions#create'
  delete "/signout" => 'sessions#destroy'
end
