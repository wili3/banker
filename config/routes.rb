Rails.application.routes.draw do
  get 'transactions/create'

  root 'transactions/create'
end
