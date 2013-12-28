CpaInvoicer::Application.routes.draw do
  get 'donor_upload/new' => 'donor_upload#new'
  post 'donor_upload' => 'donor_upload#create', as: :donor_uploads

  get 'donors/search_form' => 'donors#search_form', as: :donors_search_form
  get 'donors' => 'donors#index', as: :donors

  get 'motive_uploads/new' => 'motive_uploads#new'
  post 'motive_uploads' => 'motive_uploads#create', as: :motive_uploads

  get 'pdf_tester' => 'pdf_tester#show'

  get 'title_uploads/new' => 'title_uploads#new'
  post 'title_uploads' => 'title_uploads#create', as: :title_uploads

  get 'transactions/search_form' => 'transactions#search_form', as: :transactions_search_form
  get 'transactions' => 'transactions#search', as: :transactions

  get 'transaction_uploads/new' => 'transaction_uploads#new'
  post 'transaction_uploads' => 'transaction_uploads#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'menu#display'

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
