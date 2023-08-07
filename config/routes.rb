Rails.application.routes.draw do
  #顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    resources :items, only:[:index, :show]
    get '/customers/my_page' => 'customers#show', as: "customer"
    get '/customers/information/edit' => 'customers#edit', as: "edit_customer"
    patch '/customers/information' => 'customers#update', as: "update_customer"
    get '/customers/unsubscribe', as: "unsubscribe_customer"
    patch '/customers/withdraw', as: "withdraw_customer"
  end

  #管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :items, only:[:index, :new, :show, :edit, :create, :update]
  end

  root to: "homes#top"
  get '/homes/about', as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
