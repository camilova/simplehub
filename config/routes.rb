Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }
  get 'categories/list', to: 'categories#list', as: 'list_categories'
  resources :categories, except: [:index, :show]
  root 'items#index'
  resources :sources, except: [:index]
  get 'sources/:id/download', to: 'sources#download', as: 'download_source'
  get 'sources/:id/history', to: 'sources#history', as: 'history_source'
  resources :items, except: [:show]
end
