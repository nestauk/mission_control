Rails.application.routes.draw do
  devise_for :users

  root "projects#index"

  concern :impactable do
    resources :impact_ratings
  end

  concern :linkable do
    resources :links
  end

  concern :memberable do
    resources :memberships
  end

  concern :targetable do
    resources :indicators
  end

  resources :goals, concerns: %i[impactable linkable memberable targetable] do
    get "projects"
  end

  resources :projects, concerns: %i[impactable linkable memberable targetable] do
    get :timeline, on: :collection
  end

  # get "timeline", to: "projects#timeline", as: "timeline_projects"

  scope "indicators/:indicator_id", as: "indicator" do
    resources :progress_updates
  end

  resources :people, :organisations, :tags
end
