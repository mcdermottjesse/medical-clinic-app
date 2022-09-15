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
    resources :client_logs do
      collection do
        get :new_nurse_log
        get :new_doctor_log
        get :nurse_log_index
        get :doctor_log_index
        end
      member do
        get :edit_nurse_log
        get :edit_doctor_log
      end
    end
  end

  match "/404", :to => "errors#not_found", :via => :all

end
