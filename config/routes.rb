RoR::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  #resources :session, :only => [:new, :create, :destroy]

  post "/signin", :to => 'session#create', :as => :signin_post
  match '/signin',  :to => 'session#new'
  match '/signout', :to => 'session#destroy'

  match "/test/:par", :to => "welcome#test"

  resources :user
  root :to => 'session#new'
  match 'standarts' => 'block#index', :as => :standarts

  get "standarts/block/:number/edit" => "block#edit", :as => :block_edit
  put "standarts/block/:number" => "block#update"
  match 'standarts/block/:number' => 'block#show', :as => :block

  get "standarts/point/:code/edit" => "point#edit", :as => :point_edit
  put "standarts/point/:code" => "point#update"
  match 'standarts/point/:code' => 'point#show', :as => :point

  #match 'welcome/index' => 'welcome#index', :as => :index
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id))(.:format)'
end
