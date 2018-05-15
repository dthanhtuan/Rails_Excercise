Rails.application.routes.draw do
  resources :developers, :mcmap
  get 'slim', to: 'developers#slim_test'
  get 'js-test', to: 'developers#js_test'
  get '/hospital-detail', to: 'mcmap#hospital_detail'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :developers
    end
  end
end
