Rails.application.routes.draw do
  devise_for :admins, { registrations: "admin_registrations", sessions: "admin_sessions"}
  devise_for :doctors, controllers: { registrations: "doctor_registrations", sessions: "doctor_sessions" }
  devise_for :users, controllers: { registrations: "registrations" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'doctors' => 'doctors#index'

  get 'admin/activate' => 'admin#render_activation_form'
  post 'admin/activate' => 'admin#activate'
  
  get 'admin' => 'admin#index', as: :admin
  get 'admin/doctors' => 'admin#verify_doctors', as: :verify_doctors
  get 'admin/doctors/:id' => 'admin#verify_doctor', as: :verify_doctor
  post 'admin/doctors/:id/verify' => 'admin#verify', as: :verify

  get 'admin/plans' => 'admin#plans', as: :admin_plans
  get 'admin/plans/new' => 'admin#new_plan', as: :new_plan
  post 'admin/plans/new' => 'admin#create_plan'

  get 'admin/view/patients' => 'admin#view_patients', as: :admin_patients_view
  get 'admin/view/doctors' => 'admin#view_doctors', as: :admin_doctors_view

  get 'admin/insurance' => 'admin#insurance', as: :admin_insurance
  post 'admin/insurance/:id/complete' => 'admin#complete_insurance_payment', as: :complete_insurance_payment
  get 'admin/insurance/providers' => 'admin#insurance_providers', as: :admin_insurance_providers
  get 'admin/insurance/provider/new' => 'admin#new_insurance_provider', as: :admin_new_insurance_provider
  post 'admin/insurance/providers/create' => 'admin#create_insurance_provider', as: :admin_create_insurance_provider

  get 'admin/clinic_rentals' => 'admin#clinic_rentals', as: :admin_clinic_rentals

  get 'admin/products/categories' => 'admin#product_categories', as: :admin_product_categories
  get 'admin/products/categories/new' => 'admin#new_product_category', as: :new_product_category
  post 'admin/products/categories/add' => 'admin#add_product_category', as: :add_product_category
  get 'admin/products/categories/:category_name/products' => 'admin#category_products', as: :category_products

  get 'admin/cards/categories' => 'admin#card_categories', as: :admin_card_categories
  get 'admin/cards/categories/new' => 'admin#new_card_category', as: :new_card_category
  post 'admin/cards/categories/add' => 'admin#add_card_category', as: :add_card_category
  get 'admin/cards/categories/:category_name/cards' => 'admin#category_cards', as: :category_cards

  get 'admin/notifications' => 'admin#notifications', as: :admin_notifications
  post 'admin/notification/:id/noted' => 'admin#noted', as: :admin_noted

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

  resources :profile
  resources :doctor_profile, only: [:show, :edit, :update, :destroy]

  get '/consultation/type' => "consultation#type_select"
  get '/consultation/new/:type' => "consultation#new", as: :new_consultation
  get '/consultation/:id/pay' => "consultation#payment", as: :consultation_payment
  resources :consultation, except: :new

  get '/plans' => "plans#index"
  get '/plans/:id' => "plans#show", as: :view_product_category
  get '/plan/:id/purchase' => "plans#purchase", as: :purchase_plan
  get 'plans/confirm' => 'plans#confirm_plan'
  get 'plans/view/clinics' => 'plans#clinics', as: :view_clinics
  get 'plans/clinic/:id/book' => 'plans#book_clinic', as: :book_clinic
  post 'plans/clinic/rent/:id' => 'plans#rent_clinic', as: :rent_clinic

  resources :doctor_consultation
  post 'consultation/:id/accept' => "doctor_consultation#accept_consultation", as: :accept_consultation
  post 'consultation/:id/reject' => "doctor_consultation#reject_consultation", as: :reject_consultation

  resources :conversations, except: :new do
    resources :messages
  end

  resources :users do
    resources :patient_reviews, only: [:create]
  end

  get '/user/:user_id/consultation/:consultation_id/review' => "patient_reviews#new", as: :new_user_patient_review
  get '/review/:id/findings' => "patient_reviews#examination_findings", as: :patient_review_examination_findings
  post '/review/:id/findings' => "patient_reviews#submit_examination_findings", as: :submit_examination_findings

  resources :patient_reviews, only: [:index, :show]

  get '/knowledgebase' => 'home#knowledgebase'
  get 'refer' => 'home#render_refer_form'
  post 'refer' => 'home#refer'

  get '/care' => 'care_team#new_search'
  post '/care' => 'care_team#search_results'
  post '/care/add/:doctor_id' => 'care_team#add_doctor', as: :add_doctor_to_care_team
  get '/doctors/:id/care' => 'care_team#doctor', as: :doctor_care_team

  post 'doctors/care/request/:request_id/accept' => 'care_team#accept_care_team_request', as: :accept_care_team_request
  post 'doctors/care/request/:request_id/reject' => 'care_team#reject_care_team_request', as: :reject_care_team_request

  post 'notification/:id/noted' => 'home#noted', as: :noted

  resources :clinics

  resources :cards
  get 'cards/categories/:id' => 'cards#show_category', as: :show_card_category

  resources :wallet, only: [:show]
  get '/wallet/pay/:amount' => "wallet#pay_from_wallet", as: :pay_from_wallet
  post '/wallet/:user_id/top_up' => "wallet#top_up", as: :top_up

  put '/doctor/:id/toggle' => "doctor_profile#toggle_availability", as: :toggle_availability

  get 'conversations/select/type' => 'conversations#type_select', as: :conversations_type_select
  get '/conversation/new/:type' => "conversations#new", as: :new_conversation
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