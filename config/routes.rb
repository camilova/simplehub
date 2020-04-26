Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }
  get 'categories/list', to: 'categories#list', as: 'list_categories'
  resources :categories, except: [:index, :show]
  root 'items#index'
  resources :sources, except: [:index]
  post 'sources/:id/move', to: 'sources#move', as: 'move_source'
  get 'sources/:id/download', to: 'sources#download', as: 'download_source'
  get 'sources/:id/history', to: 'sources#history', as: 'history_source'
  get 'items/contact', to: 'items#contact', as: 'contact'
  resources :items, except: [:show]
  post 'items/:id/move', to: 'items#move', as: 'move_item'
end
