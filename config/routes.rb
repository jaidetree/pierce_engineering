PierceEngineering::Application.routes.draw do

  namespace :admin do resources :settings end

  namespace :admin do resources :pages end

	resources :news, :pages, :products
	resources :rifles, :controller => "products"

	resources :product_categories, :path => "category" do
		resources :products, :path => "product"
	end

	resources :rifle_categories, :controller => "product_categories", :path => "category" do
		resources :rifles, :controller => "products", :path => "rifle"
	end

	match '/products' => "products#index", :as => "products"
	match '/rifles' => "products#index", :as => "rifles"

	root :to => 'pages#index'

	namespace 'admin' do

		root :to => "products#index"

		resources :rifle_categories, :controller => "product_categories"
		resources :rifles, :controller => "products"
		resources :users, :product_images, :product_categories, :news, :pages

		resources :settings do
			post 'save', :on => :collection	
		end


		resources :products do
			resources :product_images do
				member do
					post 'select'
				end
			end
		end

		resources :rifles do
			resources :product_images do
				member do
					post 'select'
				end
			end
		end

		resource :session

		match '/login' => "sessions#create", :as => "login"
		match '/logout' => "sessions#destroy", :as => "logout"
		match '/navigation' => "dashboard#navigation", :as => "navigation"
		match '/support' => "dashboard#support", :as => "support"
	end

	match ':slug' => 'pages#show', :as => 'page'

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
	# root :to => "welcome#index"

	# See how all your routes lay out with "rake routes"

	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
