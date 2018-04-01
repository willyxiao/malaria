Rails.application.routes.draw do
  root 'welcome#index'
  
  get 'rules', to: 'welcome#rules'
  get 'acknowledgments', to: 'welcome#acknowledgments'
  # get 'dashboard', to:'welcome#dashboard'
  
  get 'register', to: 'welcome#register'
  get 'register/check/:hash', to: 'welcome#check_hash'
  get 'register/:hash', to: 'welcome#register_hash'

  get 'login', to: 'welcome#login'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'email', to: 'welcome#email'
  post 'email', to: 'welcome#email_submit'
  get 'email/:hash', to: 'welcome#email_confirm'
  post 'kill', to: 'welcome#kill'
  post 'death_story', to: 'welcome#death_story'
  post 'question', to: 'welcome#malaria_question_submit'
  get 'final_stats', to: 'welcome#final_stats', as: 'final_stats'
  
  get 'users_list', to: 'welcome#users_list', as: 'users_list'
  
  scope '/api' do
    get 'user', to: 'api#user'
    get 'malaria_fact', to: 'api#malaria_fact'
  end

  scope '/admin' do
    get '/', to: 'admin#dashboard', as: :admin
    get '/community/:community_id', to: 'admin#community', as: :admin_community
    get '/community/:community_id/game', to:'admin#start_game', as: :admin_start_game
    post '/login', to: 'admin#login'
    get '/login', to: 'admin#login_page', as: :admin_login
    get '/logout', to:'admin#logout', as: :admin_logout
    get '/stats', to:'admin#stats', as: :admin_stats
  end
end
