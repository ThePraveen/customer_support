Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'comments/create'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'comments/index'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'comments/show'
    end
  end

  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          confirmations:        'api/v1/confirmations',
          omniauth_callbacks:   'api/v1/omniauth_callbacks',
          passwords:            'api/v1/passwords',
          registrations:        'api/v1/registrations',
          sessions:             'api/v1/sessions',
          token_validations:    'api/v1/token_validations'
      }

      resources :users
      put "/issues/:id/add_comment", to: "users_controller#add_comment"

      resources :issues
      resources :issue_types
    end
  end
end