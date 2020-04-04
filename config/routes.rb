Rails.application.routes.draw do
  root 'items#index'
  resources :sources
  resources :orders
  resources :items
end
