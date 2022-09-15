Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  authenticated :user do
    root "projects#index", as: :authenticated_root
  end

  root "pages#about"
  get "/about", to: "pages#about"

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
    get :activity
    get :timeline, on: :collection
    resources :key_dates
  end

  scope "indicators/:indicator_id", as: "indicator" do
    resources :progress_updates
  end

  resources :people, :organisations, :tags

  get "/dashboards/impact", to: "dashboards#impact", as: "impact_dashboard"

  scope :api, as: :api do
    get "/people/:id/capacity", to: "people#capacity", as: "people_capacity"
    get "/impact_types/:id/impact_rigours", to: "impact_options#impact_rigours"
    get "/impact_rigours/:id/impact_levels", to: "impact_options#impact_levels"
  end
end
