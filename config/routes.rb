Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#show', page: 'home'
end
