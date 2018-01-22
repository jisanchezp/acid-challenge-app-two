Rails.application.routes.draw do
  root'users#index'
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]

  namespace :rest, defaults: {format: 'json'} do
    post 'verify/:email', to: 'sessions#verify',
      :constraints  => {
        :email => /[0-z\.]+/ #allows email addresses to contain dots in url
      }
  end
end
