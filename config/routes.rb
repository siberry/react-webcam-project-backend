Rails.application.routes.draw do
  resources :search_terms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "/search", to: "webcams#search"
      resources :webcams, only: :index
    end
  end
end
