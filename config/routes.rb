require 'sidekiq/web'
require 'sidekiq/cron/web'
Rails.application.routes.draw do
  # root 'prescription#prescription'
  # post 'create', to: 'prescription#prescription'
  resources :prescriptions, only: [:create, :new]
  mount Sidekiq::Web => '/sidekiq'
end
