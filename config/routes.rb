Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
devise_scope :user do
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end
end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end

  namespace :admin do
    resources :users
  end

end
