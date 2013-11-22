JE::Application.routes.draw do
  get "mailbox/inbox"
  get "mailbox/sentbox"
  get "mailbox/show/:id", to: 'mailbox#show', as: 'mailbox_show'
  delete "mailbox/destroy", to: 'mailbox#destroy', as: 'mailbox_destroy'
  put "mailbox/undestroy", to: 'mailbox#undestroy', as: 'mailbox_undestroy'
  get "mailbox/trash"
  post "mailbox/reply", to: 'mailbox#reply', as: 'mailbox_reply'
  devise_for :users
  root "static_pages#home"
  get "static_pages/help"
  match '/contact', to: 'static_pages#contact', via: 'get'
  get '/users/:id', to: 'users#show', as: 'user_show'
  get '/users/', to: 'users#index', as: 'user_index'
  delete '/users/delete', to: 'users#destroy', as: 'user_delete'
  get '/users/edit/avatar', to: 'users#edit_avatar', as: 'edit_user_avatar'
  get '/users/edit/cv', to: 'users#edit_cv', as: 'edit_user_cv'
  get '/users/edit/bateaux', to: 'users#edit_bateaux', as: 'edit_user_bateaux'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
