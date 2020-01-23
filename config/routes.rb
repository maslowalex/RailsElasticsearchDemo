Rails.application.routes.draw do
  root to: 'main#index'
  get :search, controller: :main
end
