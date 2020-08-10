Rails.application.routes.draw do
  #devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    namespace 'v1' do
      resources :sessions, only: [:create, :destroy]
      get "/current_user", to: "sessions#get_user"
      resources :posts do
        resources :comments
      end
    end
  end
end
