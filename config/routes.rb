Rails.application.routes.draw do
  root to: 'web/tasks#index'

  scope module: 'web' do
    resource :session, only: %i[new create destroy]
    resources :dashboard, only: :index
    resources :tasks do
      resource :state_event, only: :create, controller: 'tasks/state_events'
    end

    namespace :admin do
      resources :dashboard, only: :index
      resources :tasks
    end
  end
end
