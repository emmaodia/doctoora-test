Rails.application.routes.draw do
  devise_for :doctors, controllers: { registrations: "doctor_registrations", sessions: "doctor_sessions" }
  devise_for :users, controllers: { registrations: "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'doctors' => 'doctors#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :onboarding, only: [:new, :create]
  get '/onboarding/new/additional_info' => "onboarding#additional_info"
  post '/onboarding/create' => "onboarding#submit_additional_info"

  resources :doctor_onboarding, only: [:new, :create]
  get 'doctor/onboarding/new/upload_documents' => "doctor_onboarding#upload_documents"
  post 'doctor/onboarding/create' => "doctor_onboarding#submit_documents"

  resources :profile, only: [:show, :edit, :update]
  resources :doctor_profile, only: [:show, :edit, :update]

  resources :consultation

  get '/plans' => "plans#index"
  get '/plan/:id/purchase' => "plans#purchase", as: :purchase_plan
  get 'plans/confirm' => 'plans#confirm_plan'

  resources :doctor_consultation
  post 'consultation/:id/accept' => "doctor_consultation#accept_consultation"
  post 'consultation/:id/reject' => "doctor_consultation#reject_consultation"

  resources :conversations do
    resources :messages
  end

  resources :users do
    resources :patient_reviews, only: [:index, :new, :create]
  end

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