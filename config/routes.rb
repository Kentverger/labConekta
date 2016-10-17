Rails.application.routes.draw do
  namespace :v1 do
    post  "cards/actions/tokenize", to: "cards#create"
    resource :customers, only: [:create]
  end
end
