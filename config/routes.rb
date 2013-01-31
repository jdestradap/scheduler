Scheduler::Application.routes.draw do
  get "home/index"
  get "calendar/index"

  devise_for :users
  match '/admin' => 'admin#index'

  namespace :admin do
    resources :appointments
    resources :doctors
    resources :patients
  end

  root :to => 'home#index'
end
