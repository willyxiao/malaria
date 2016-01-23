Rails.application.routes.draw do
  root to: redirect('/register')
  
  get 'rules', to: 'welcome#rules'
  # get 'dashboard', to:'welcome#dashboard'
  
  get 'register', to: 'welcome#register'
  get 'register/:hash', to: 'welcome#register_hash'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  # get 'admin', to: 'admin#dashboard'
  # post 'admin/login', to:'admin#login'
  # get 'admin/login', to:'admin#login_page'

end
