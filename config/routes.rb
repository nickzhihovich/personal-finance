Rails.application.routes.draw do
  get ':page' => 'pages#show'
  root to: 'pages#show', page: 'home'
end
