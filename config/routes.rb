Rails.application.routes.draw do
  get 'pages/Home', as: 'homepage'
  get 'pages/doctors', as: 'ondoctors'
  get 'hospitals/:id/doctors', to: 'hospitals#assign_doc',  as: 'doctors'
  post 'hospitals/:id/doctors', to: 'hospitals#associate_doc'
  
  get 'pages/patient/:id', to: 'pages#selected_treatment', as: 'selectedtreatment'
  
  get 'requests/requests', as: 'requests'
  get 'requests/requests_info', to: 'requests#requests_info', as: 'requestsinfo'
  
  get '/hospitals/:id/assigntreatment', to: 'hospitals#assign_treatment', as: 'assigntreatment'
  post '/hospitals/:id/assigntreatment', to: 'hospitals#associate_treatment', as: 'associatetreatment'
  
  get '/requests/patient/:id/treatments', to: 'requests#set_appointment', as: 'appointment'

  get '/requests/requests/:id/accept', to: 'requests#accept', as: 'accept'
  get '/requests/requests/:id/reject', to: 'requests#reject', as: 'reject'

  get 'hospitals/:id/treatment/:id2', to: 'hospitals#remove_treatment', as: 'removetreatment'
  get 'hospitals/:id/doctor/:id2', to: 'hospitals#remove_doctor', as: 'removedoctor'

  devise_for :users
  resources :hospitals
  resources :treatments
  root to: "pages#Home"
end
