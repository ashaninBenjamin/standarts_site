RoR::Application.routes.draw do
  scope module: :web do
    resources :standards do
      get "take_pattern", on: :collection
    end
    resources :helps, :news, only: [:index, :show]

    resource :user do
      resource :profile, :company, only: [:show, :new, :create, :edit, :update]
    end

    namespace :admin do
      resources :users, only: [:index, :show, :destroy]
      resources :profiles, :companies, only: [:index, :show, :destroy]
      resources :session_histories, only: [:index, :destroy]
      resources :helps
      resources :news
    end
    resource :session, only: [:new, :create, :destroy]

    match "helper/number_selection" => "standards#number_selection"

    root to: 'standards#index'
  end

  namespace :api do
    resources :news, only: [:index, :show]
  end

  mount Ckeditor::Engine => '/ckeditor'
end