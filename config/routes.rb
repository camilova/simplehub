Rails.application.routes.draw do
  resources :sources
  resources :orders
  resources :items
end
