Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"   # ✅ HANYA SATU

  namespace :admin do
    resources :users
  end
end
