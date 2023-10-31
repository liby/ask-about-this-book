Rails.application.routes.draw do
  post '/api/ask', to: 'questions#ask'

  get '/questions/:id', to: 'main#index'

  # TODO: Add user authentication before re-enabling this route.
  # get '/db', to: 'questions#db'

  root 'main#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
