PentakillUniversity::Application.routes.draw do  

  devise_for :users
  get "app/accept/:id" => 'app#accept', :as => 'accept_app'
  get "app/decline/:id" => 'app#decline', :as => 'decline_app'
  get "request/accept/:id" => "request#accept:", :as => 'accept_request'
  get "request/decline/:id" => 'request#decline', :as => 'decline_request'  
  get "user/verify"
  get "user" => 'user#profile'
  get "user/requests"
  get "user/apps"
  get "home/index"
  get "students" => 'user#students'
  get "mentors" => 'user#mentors'
  get "user/:id/request" => 'user#request_mentorship', :as => 'request'
  get "user/:id/apply" => 'user#apply', :as => 'apply'
  get "user/:id" => 'user#show', :as => 'show'
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
