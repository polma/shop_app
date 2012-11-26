ShopApp::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" unless Rails.env.production?
  resource :shop
  
  root :to => "shop#index"
  resources :products
  resources :categories
  resources :orders
  
  namespace :admin do
    root :to => "orders#index"
    resources :products
    resources :categories
    resources :orders
  end
  devise_for :admins

  match 'cart/add/:id' => "cart#add"
  match 'cart/index' => "cart#index"
  match 'order/confirm' => "order#confirm"
  match 'order/validate_address' => "order#validate_address"

  match 'search/results' => "search#results"

  resource :spa
  match 'spa' => 'spas#show'
  match 'spa/get_categories' => "spas#get_categories"
  match 'spa/get_products' => "spas#get_products"
  match 'spa/add_to_cart/:id' => "cart#add"
  match 'cart/get' => "cart#get"
  match 'order/confirm_json' => "order#confirm_json"

  # The priority is based upon order of creation:
  # first created -> highest priority.:w
  #

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
  # match ':controller(/:action(/:id))(.:format)'
end
