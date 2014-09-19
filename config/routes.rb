A::Application.routes.draw do
  scope '/admin' do
    resources :articles
  end
  match 'articles/:url' => 'articles#public', :as => :article
  #match '/home' => 'static#home', :as => :home
  match '/about' => 'static#about', :as => :about
  match '/contact' => 'static#contact', :as => :contact
  match '/trebovaniya' => 'static#trebovaniya', :as => :trebovaniya
  match '/vizitki' => 'static#vizitki', :as => :vizitki

  #temp blank stuff
  match '/silk' => 'static#index', :as => :silk
  match '/upprint' => 'static#index', :as => :upprint
  match '/tisnenie' => 'static#index', :as => :tisnenie
  match '/vyrubka' => 'static#index', :as => :vyrubka
  match '/uflak' => 'static#index', :as => :uflak
  match '/printer' => 'static#index', :as => :printer
  match '/cards' => 'static#index', :as => :cards
  match '/folders' => 'static#index', :as => :folders
  match '/plasticfolders' => 'static#index', :as => :plasticfolders
  match '/stickers' => 'static#index', :as => :stickers
  #end of temp blank stuff

  #resources :articles

  resources :index

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
  root :to => "static#home" #"index#index"
  #map.connect '',:controller=>"index",:action=>"index"
  match 'index/result'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
