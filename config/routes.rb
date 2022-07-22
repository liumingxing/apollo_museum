Rails.application.routes.draw do
  root to: 'trips#index'

  get 'museums', to: 'museums#index'

  #http://localhost:3000/users/sign_in

  devise_for :users, controllers: { 
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :trips do 
    member do
      delete :remove_museum_from_trip
      post :add_museum_to_trip
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
