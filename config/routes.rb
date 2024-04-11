Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'admin/invitations' }, skip: [:registrations]
  
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

  resources :clients do
    resources :client_logs
  end

  resources :medications, only: [:index, :new, :create]

  resources :client_medications, only: [:destroy]

  match "/404", :to => "errors#not_found", :via => :all

end
