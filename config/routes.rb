Rails.application.routes.draw do
  root "welcome#index" 
  get 'dashboard', to:'welcome#dashboard'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'admin', to: 'admin#dashboard'
  post 'admin/login', to:'admin#login'
  get 'admin/login', to:'admin#login_page'

end
