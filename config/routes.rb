Ghapi::Application.routes.draw do

  root :to => 'home#index'

  get '/auth/:provider/callback', to: 'user_session#create'
end
