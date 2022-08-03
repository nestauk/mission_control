Rails.application.routes.draw do
  devise_for :users

  root "goals#index"

  concern :impactable do
    resources :impact_ratings
  end

  concern :memberable do
    resources :memberships
  end

  concern :targetable do
    resources :indicators
  end

  resources :goals, concerns: %i[impactable memberable targetable] do
    get "objectives"
  end

  resources :objectives, concerns: %i[impactable memberable targetable]
  get "timeline", to: "objectives#timeline", as: "timeline_objectives"

  scope "indicators/:indicator_id", as: "indicator" do
    resources :progress_updates
  end

  resources :people, :organisations
end
