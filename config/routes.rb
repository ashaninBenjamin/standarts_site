RoR::Application.routes.draw do
  scope module: :web do
    resources :standards
    resources :public_standards, only: [:index, :show] do
      get :take, on: :member
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

    root to: 'standards#index'
  end

  namespace :api do
    resources :news, only: [:index, :show]
    resources :standards, only: [] do
      get :numbers, on: :member
    end
  end

  mount Ckeditor::Engine => '/ckeditor'
end