Rails.application.routes.draw do
  resources :categories
  root 'items#index'
  resources :sources
  get 'sources/:id/download', to: 'sources#download', as: 'download_source'
  resources :orders
  resources :items
end
