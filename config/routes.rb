Rails.application.routes.draw do
  namespace :v1 do
    resource :customers, only: [:create]
  end
end
