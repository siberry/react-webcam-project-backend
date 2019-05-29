Rails.application.routes.draw do
  resources :search_terms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      post "/search", to: "webcams#search"
      get "/featured", to: "webcams#featured"
      resources :webcams, only: [:index, :show]
      post "/login", to: "users#login"
    end
  end
end
