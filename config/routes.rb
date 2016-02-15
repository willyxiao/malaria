Rails.application.routes.draw do
  root 'welcome#weebly_copy'
  # root 'welcome#index'

  get 'why', to: 'welcome#why'
  
  get 'rules', to: 'welcome#rules'
  # get 'dashboard', to:'welcome#dashboard'
  
  get 'register', to: 'welcome#register'
  get 'register/check/:hash', to: 'welcome#check_hash'
  get 'register/:hash', to: 'welcome#register_hash'

  get 'login', to: 'welcome#login'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  scope '/api' do
    get 'user', to: 'api#user'
  end

  # get 'admin', to: 'admin#dashboard'
  # post 'admin/login', to:'admin#login'
  # get 'admin/login', to:'admin#login_page'

end
