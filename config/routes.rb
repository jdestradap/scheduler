Scheduler::Application.routes.draw do
  get "welcome/index"

  devise_for :users
  match '/admin' => 'admin#index'
  resources :appointments
  resources :time_slots

  namespace :admin do
    resources :appointments
    resources :doctors
    resources :patients
  end

  root :to => 'welcome#index'
end
