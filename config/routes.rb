Rails.application.routes.draw do
  resources :developers
  get 'slim', to: 'developers#slim_test'
  get 'js-test', to: 'developers#js_test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :developers
    end
  end
end
