MyVacancy::Application.routes.draw do
  get "homes/index"

  root :to => 'homes#index'

  #rotas devise
  devise_for :users

  #rotas fixas
  match '/admin/homes/update_situation' => "admin/homes#update_situation"  

  namespace :admin do
    root :to => 'homes#index'
    resources :comments, :except => [:show, :edit] do 
      get 'comments_by_situation', :on => :collection
    end

    resources :proposals, :except => [:show, :edit] do 
      get 'proposals_by_situation', :on => :collection    
    end

    resources :users, :except => :new do 
      put 'update_situation', :on => :member 
    end

    resources :announcements do
      put 'update_situation', :on => :member 
      collection do
        get 'find_cities_by_state' 
        get 'announcements_by_category'
      end  
    end

  end

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
  # match ':controller(/:action(/:id))(.:format)'
end
