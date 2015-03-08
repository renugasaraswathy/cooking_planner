Rails.application.routes.draw do
  resources :ingredients
  get '/recipes/prerequisities/:id'=>'recipes#prerequisities',as: :prerequisities_recipes
  get '/recipes/steps/:id'=>'recipes#steps',as: :steps_recipes
  get '/recipes/ingredients/:id'=>'recipes#ingredients',as: :ingredients_recipes
  get '/recipes/ingredients_list'=>'recipes#ingredients_list',as: :ingredients_list
  post '/recipes/save_prerequisities/:id'=>'recipes#save_prerequisities'
  post '/recipes/save_steps/:id'=>'recipes#save_steps'
  post '/recipes/save_ingredients/:id'=>'recipes#save_ingredients'
  post '/recipes/add_recipe_to_date/:id'=>'recipes#add_recipe_to_date',as: :add_recipe_to_date_recipes
  resources :recipes

  resources :categories do
    member do
      get 'sub_categories'
    end
  end

  get 'home'=>'home#index'
  get 'home/join_a_family'=>'home#join_a_family',:as=>'join_a_family_home'
  get 'plans_on/:date'=>'home#plans_on',:as=>'plans_on'
  resources :families
  get '/family/join'=>'families#join',:as=>'join_family'
  post '/family/joining'=>'families#joining',:as=>'joining_family'
  devise_for :users,:controllers=>{:omniauth_callbacks => "users/omniauth_callbacks"}
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'
   resources :users
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
