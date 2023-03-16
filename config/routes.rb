Rails.application.routes.draw do

  # our PURL resolver has redirects to the old application resource pattern. For example:
  # http://purl.dlib.indiana.edu/iudl/em/Alajaji/910339 redirects to
  # https://ethnomultimedia.org/https://ethnomultimedia.org/media.html?aid=Alajaji/910339 which is the annotation with
  # id 910339. The "aid" portion is a combination of author last name and annotation ID
  get '/media.html', to: 'annotations#purl', as: "purl_redirector"

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get 'activation', to: 'users#activation', as: "activation"
  get 'activate/:key', to: 'users#activate', as: "activate"
  get 'reactivation', to: 'users#reactivation', as: 'reactivation'
  post "reactivate", to: "users#reactivate", as: "reactivate"

  get 'users/reset/:key', to: "users#reset", as: 'users_reset'
  post 'users/reset/:id', to: "users#reset"


  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  get '/request_reset' => "users#reset_password"
  post '/request_reset' => "users#reset_password"



  get "books", to: "books#index", as: "books"
  get "book/:id", to: "books#show", as: "book"
  get "/search", to:"application#search", as: "search"

  get "annotation/:id", to: 'annotations#show', as: "annotation"
  get "sample/:id", to: "annotations#sample", as: "sample"
  get "about", to: "application#about", as: "about"
  get "faq", to: "application#faq", as: 'faq'
  get "contact", to: "application#contact", as: "contact"

  root "application#home"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
