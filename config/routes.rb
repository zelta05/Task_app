Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help', as: 'help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post 'signup',   to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  
  scope "/tasks" do
    get'/new', to: 'tasks#quick_new_task', as: "quick_new_task"
    post'/', to: 'tasks#create', as: "post_quick_new_task"
    get'/all-active-tasks', to: 'tasks#all_active_tasks', as: "all_active_tasks"
    get'/all-complete-tasks', to: 'tasks#all_complete_tasks', as: "all_complete_tasks"
    get'/all-overdue-tasks', to: 'tasks#all_overdue_tasks', as: "all_overdue_tasks"
  end

  resources :projects do
    get :overdue, on: :collection
    get :complete, on: :collection

    post '/delete_collaborator', to: 'projects#delete_collaborator'

    resources :comments, :notes, shallow: true

    resources :tasks, shallow: true do 
      get :complete, on: :collection, to: "tasks#complete"
      get :overdue, on: :collection, to: "tasks#overdue"
    end
  end

  patch '/edit_user_project_permission', to: 'user_projects#edit_user_project_permission'

  namespace :admin do 
    get 'dashboard' => 'dashboard#index', :as => :dashboard
    get 'tags' => 'dashboard#tags', :as => :tags
    get 'users' => 'dashboard#users', :as => :users
    get 'users/:id' => 'dashboard#user_edit', :as => :user_edit
  end

end
