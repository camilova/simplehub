Rails.application.routes.draw do
  resources :categories, except: [:index, :show]
  root 'items#index'
  resources :sources, except: [:index]
  get 'sources/:id/download', to: 'sources#download', as: 'download_source'
  get 'sources/:id/history', to: 'sources#history', as: 'history_source'
  resources :items, except: [:show]
  get 'administration', to: 'administration#index', as: 'administration'
end
