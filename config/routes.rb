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
<<<<<<< HEAD
<<<<<<< HEAD
    resources :locations, only: [:index, :show, :create, :update, :destroy]
=======
    resources :disaster_reports, only: [:index, :create]
>>>>>>> adds disaster_report route
=======
    resources :disaster_reports, only: [:index, :create]
>>>>>>> 64f2e87795baf593fb2dbdb40d1d69a0d69b619f
    end
  end
end
