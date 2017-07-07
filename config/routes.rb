Rails.application.routes.draw do
  resources :events

  resources :locations do
    resources :events
  end

  resources :participants do
    resources :events
  end

  resources :locations do
    resources :events, only: :index
  end

  resources :events do
    resources :participants, only: :index
  end


  get 'welcome/home'
  root 'welcome#home'

  get '/signin' => "sessions#signin"
  post '/signin' => 'sessions#signin_post', as: "signin_post"
  get '/signup' => 'sessions#signup'
  post '/signup' => 'sessions#signup_post', as: "signup_post"
  delete "/signout" => 'sessions#signout'

  get '/auth/facebook/callback' => 'sessions#facebook'
end
