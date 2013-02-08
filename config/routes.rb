Scheduler::Application.routes.draw do
  get "welcome/index"

  devise_for :users, controllers: {registrations: "registrations"}

  match '/admin' => 'admin#index'
  match '/calendar' => 'calendar#index'
  resources :appointments

  namespace :admin do
    resources :appointments
    resources :doctors
    resources :patients
  end

  namespace :calendar do
    resources :time_slots
    resources :appointments
  end

  root :to => 'welcome#index'
end
