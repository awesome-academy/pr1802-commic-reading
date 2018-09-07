Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :categories do
    resources :comics
  end
  resources :users do
    resources :follows, only: [:create, :destroy, :index]
  end
  resources :comics do
    resources :chapters
    resources :rates, only: [:create, :update]
  end
  resources :authors
  resources :chapter_attachments
end
