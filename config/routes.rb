Rails.application.routes.draw do
  resources :questions, only: [:create, :show, :index]

  post '/api/ask', to: 'questions#ask'

  root 'main#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
