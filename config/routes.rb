Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'pages#home'

  get 'activity_page' => 'transactions#index'

  resources :transactions, only: %i[index destroy] do
    collection do
      match 'search', to: 'transactions#search', via: %i[get post], as: :search
    end
  end
  resources :balance_transactions, except: %i[index show destroy]
  resources :expense_transactions, except: %i[index show destroy]
  resources :between_categories_transactions, only: %i[new create]

  resources :categories do
    get 'add_money', on: :member, to: 'category_transactions#new'
    post 'update_balance', on: :member, to: 'category_transactions#create'
  end

  get '/date_chart', to: 'pages#date_chart'
end
