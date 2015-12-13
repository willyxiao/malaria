Rails.application.routes.draw do

  root "welcome#index" 
  get 'dashboard', to:'welcome#dashboard'
  get 'rules', to:'welcome#rules'
  get 'get_involved', to:'welcome#get_involved'
  get 'about', to:'welcome#about'
  get 'facts', to:'welcome#facts'
  get 'quiz', to: 'welcome#quiz'
  
  post 'quiz', to: 'welcome#grade_quiz'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'admin', to: 'admin#dashboard'
  post 'admin/login', to:'admin#login'
  get 'admin/login', to:'admin#login_page'
  
end
