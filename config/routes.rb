Rails.application.routes.draw do
  get '/404', to: 'errors#not_found'
  get '/422', to: 'errors#unprocessable'
  get '/500', to: 'errors#internal_server_error'
  get '/4000', to: 'errors#invalid_params'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #Unfortunately, now out URls look like: http://api.example.com/api/v1/people. 
  #We can remove the duplication of “api” by setting a blank path:
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :upload
      #match 'upload', to: 'upload#process', via: [:post]
    end
  end
end
