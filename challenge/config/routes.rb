Rails.application.routes.draw do
  root "employees#index"
  resources :employees do
    get :report, on: :collection
  end
end
