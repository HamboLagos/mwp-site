MwpSite::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest
  # priority.
  # See how all your routes lay out with "rake routes".

  root 'posts#index'

  #posts

  #athletes
  resources :athletes, only: [:create, :edit, :update, :destroy, :show] do
    resources :posts
  end
  get '/roster' => 'athletes#index'
  get '/signup' => 'athletes#new'
  get '/athletes/:id/change_password' => 'athletes#change_password',
    as: :change_password
  post '/athletes/:id/change_password' => 'athletes#commit_password_change',
    as: :commit_password_change


  # sessions (authentication)
  resources :sessions, only: [:create]
  get '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  #seasons
  resources :seasons, only: [:new, :create]

  #tournaments
  resources :tournaments do |key|
    resources :tournament_steps, controller: 'tournament_steps'
  end


  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions
  # automatically):
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
