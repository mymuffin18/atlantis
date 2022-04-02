Rails.application.routes.draw do
  devise_for :admins,
  controllers: {
    sessions: 'api/v1/admin_sessions'
  }, defaults: {format: :json},
  :skip => [:registrations]

  devise_for :users,
  controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }, defaults: {format: :json}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
    resources :disasters, only: [:index, :show, :create, :update, :destroy]
    resources :members, only: [:index, :show, :update]
    resources :locations, only: [:index, :show, :create, :update, :destroy]
    resources :disaster_reports, only: [:index, :create, :show, :update, :destroy]
    get 'pending_reports/', to: 'disaster_reports#pending_reports'
    put 'disaster_reports/:id/vote', to: 'disaster_reports#vote'
    resources :earthquakes, only: [:index]
    resources :admin_reports, only: [:index, :show, :destroy]
    put 'admin_reports/:id/approve', to: 'admin_reports#approve'
    get 'admins/pending_reports', to: 'admin_reports#pending_reports'
    get 'users/disasters', to: 'disaster_reports#disaster_types'
    resources :users, only: [:index]
    end
  end
end
