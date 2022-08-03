Rails.application.routes.draw do
  get 'pages/Home', as: 'homepage'
  get 'pages/doctors', as: 'ondoctors'
  get 'hospitals/:id/doctors', to: 'hospitals#assign_doc',  as: 'doctors'
  post 'hospitals/:id/doctors', to: 'hospitals#associate_doc',  as: 'doctors2'
  
  get 'pages/patient', to: 'pages#patient', as: 'patient'
  get 'pages/patient/:id', to: 'pages#selected_treatment', as: 'selectedtreatment'
  
  get 'requests/requests', as: 'requests'
  get 'requests/requests_info', to: 'requests#requests_info', as: 'requestsinfo'
  devise_for :users
  # devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  resources :hospitals
  resources :treatments
  root to: "pages#Home"
  
  get '/hospitals/:id/assigntreatment', to: 'hospitals#assign_treatment', as: 'assigntreatment'
  post '/hospitals/:id/assigntreatment', to: 'hospitals#associate_treatment', as: 'associatetreatment'
  # post 'pages/patient', to: 'pages#selectedtreatment', as 'selectedtreatment'

  # get '/pages/patient/:id/treatments', to: 'pages#appointment', as: 'appointment'
  get '/requests/patient/:id/treatments', to: 'requests#set_appointment', as: 'appointment'

  get '/requests/requests/:id/accept', to: 'requests#accept', as: 'accept'
  get '/requests/requests/:id/reject', to: 'requests#reject', as: 'reject'

  get 'hospitals/:id/:id2', to: 'hospitals#remove_treatment', as: 'removetreatment'

  # put '/pages/doctors/:id/hospital', to: 'pages#assignhosp2', as: 'assignhosp2'
  # post '/hospitals/associatetreatment', to: 'hospitals#associatetreatment', as: 'associatetreatment'
end
