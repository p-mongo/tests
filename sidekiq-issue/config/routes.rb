require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :admins

  authenticated :admin do
    mount Sidekiq::Web => '/sidekiq'
  end
end
