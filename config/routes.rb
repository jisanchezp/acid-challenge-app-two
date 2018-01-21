Rails.application.routes.draw do
  namespace :rest, defaults: {format: 'json'} do
    post 'verify/:email', to: 'sessions#verify',
      :constraints  => {
        :email => /[0-z\.]+/ #allows email addresses to contain dots in url
      }
  end

  resources :users
end
