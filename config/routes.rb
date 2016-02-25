Rails.application.routes.draw do

  mount Sidekiq::Web => "/sidekiq" # monitoring console

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #get '/listings/mylocation' => 'listings#create_location_based', :as => :location_listing
  #get '/listings/:location' => 'listings#show', :as => :listing
  get '/listings/:latitude/:longitude', to: 'listings#show', :as => :location_listing, :constraints => {:latitude => /\-?\d+(.\d+)?/, :longitude => /\-?\d+(.\d+)?/ }
  get '/listings/:latitude/:longitude/:id', to: 'houses#show',  :constraints => {:latitude => /\-?\d+(.\d+)?/, :longitude => /\-?\d+(.\d+)?/ }
  resources :listings, only: [:show, :new, :create, :post], param: :location do
      #resources :houses, only: [:show]
      get '/:id' => 'houses#show', :as => :short_house
  end
  resources :favourites, only: [:index, :show, :create, :destroy ]
  #get "/listings/new" => "listings#new", :as => :new_listings
  #post "/listings" => "listings#create", :as => :clistings, via: :post
  #get "/listings/:location" => "listings#show", :as => :show_listings
  
  # You can have the root of your site routed with "root"
  root "listings#new"
  get "/help" => 'home#help', :as => :help

 #resources :listings, :only [ :index]


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end