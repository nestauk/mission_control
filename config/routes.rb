Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "goals#index"

  concern :targetable do
    resources :indicators
  end

  resources :goals, concerns: %i[targetable] do
    get "objectives"
  end

  resources :objectives, concerns: %i[targetable]

  scope 'indicators/:indicator_id', as: 'indicator' do
    resources :progress_updates
  end
end
