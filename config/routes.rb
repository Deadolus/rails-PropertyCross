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

  #redirect every other request
  get '*path' => 'home#invalid_route'

end
