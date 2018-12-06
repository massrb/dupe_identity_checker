Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  get '/checker/index', to: 'checker#index'
  post '/checker/upload_csv', to: 'checker#upload_csv'
  root 'checker#index'

end
