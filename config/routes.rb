Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'users/new'

  get 'users/create'

  get '/auth/:provider/callback' => 'login#callback'

  post 'answers/createAsync' => 'answers#createViaAjax'


  resources :notes, only: [:show, :index, :destroy]

  get 'notes/sync/initial'=> 'notes#initial_sync'
  get 'notes/sync/evernote'=> 'notes#sync'

  get 'notes/sync/content'=> 'notes#sync_all_notes_content'

  get 'notebooks/list' => 'notebook#list_all'


  resources :questions
  resources :answers

  get '/quiz/generate/new_least_answered' => 'quiz#new_least_answered'
  post 'quiz/generate/custom' => 'quiz#new_custom'

  resources :quiz, only: [:new, :show, :create, :index]
  get 'quizzes/sync/'=> 'quiz#sync'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  
  # root 'notes#index'
  root 'sessions#create'

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
