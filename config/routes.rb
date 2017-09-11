Rails.application.routes.draw do
  devise_for :admins, { registrations: "admin_registrations", sessions: "admin_sessions"}
  devise_for :doctors, controllers: { registrations: "doctor_registrations", sessions: "doctor_sessions" }
  devise_for :users, controllers: { registrations: "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'doctors' => 'doctors#index'

  get 'admin' => 'admin#index', as: :admin
  get 'admin/doctors' => 'admin#verify_doctors', as: :verify_doctors
  get 'admin/doctors/:id' => 'admin#verify_doctor', as: :verify_doctor
  post 'admin/doctors/:id/verify' => 'admin#verify', as: :verify

  get 'admin/plans' => 'admin#plans', as: :admin_plans
  get 'admin/plans/new' => 'admin#new_plan', as: :new_plan
  post 'admin/plans/new' => 'admin#create_plan'

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

  get '/consultation/type' => "consultation#type_select"
  get '/consultation/new/:type' => "consultation#new", as: :new_consultation
  resources :consultation, except: :new

  get '/plans' => "plans#index"
  get '/plan/:id/purchase' => "plans#purchase", as: :purchase_plan
  get 'plans/confirm' => 'plans#confirm_plan'

  resources :doctor_consultation
  post 'consultation/:id/accept' => "doctor_consultation#accept_consultation", as: :accept_consultation
  post 'consultation/:id/reject' => "doctor_consultation#reject_consultation", as: :reject_consultation

  resources :conversations do
    resources :messages
  end

  resources :users do
    resources :patient_reviews, only: [:new, :create]
  end

  resources :patient_reviews, only: [:index]

  get '/knowledgebase' => 'home#knowledgebase'

  get '/care' => 'care_team#new_search'
  post '/care' => 'care_team#search_results'
  post '/care/add/:doctor_id' => 'care_team#add_doctor', as: :add_doctor_to_care_team
  get '/doctors/:id/care' => 'care_team#doctor', as: :doctor_care_team

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