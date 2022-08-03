Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "goals#index"

  concern :memberable do
    resources :memberships
  end

  concern :targetable do
    resources :indicators
  end

  resources :goals, concerns: %i[memberable targetable] do
    get "objectives"
  end

  resources :objectives, concerns: %i[memberable targetable]
  get "timeline", to: "objectives#timeline", as: "timeline_objectives"

  scope "indicators/:indicator_id", as: "indicator" do
    resources :progress_updates
  end

  resources :people, :organisations
end
