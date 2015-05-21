Spree::Core::Engine.routes.draw do
  resources :newsletter_subscriptions, only: [:create]
end
