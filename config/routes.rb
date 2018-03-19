Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'pages#home'

  get 'activity_page' => 'transactions#index'
  resources :transactions, except: %i[index show] do
    collection do
      match 'search', to: 'transactions#search', via: %i[get post], as: :search
    end
  end
  resources :categories, except: :show
end
