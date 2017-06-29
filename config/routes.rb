Rails.application.routes.draw do
  get 'welcome/home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'

  get '/signin' => "sessions#signin"
  post '/signin' => 'sessions#signin_post', as: "signin_post"
  get '/signup' => 'sessions#signup'
  post '/signup' => 'sessions#signup_post', as: "signup_post"
  delete "/signout" => 'sessions#signout'
end
