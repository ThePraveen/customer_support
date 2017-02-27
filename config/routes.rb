Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # constraints subdomain: 'api' do
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
      end
    end
  # end
end
