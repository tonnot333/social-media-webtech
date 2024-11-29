Rails.application.routes.draw do
  # Root Page
  root 'sessions#new'

  # User Authentication
  get '/register', to: 'users#new' # แสดงหน้า Register
  post '/register', to: 'users#create' # รับข้อมูลและสร้างบัญชี
  get '/login', to: 'sessions#new' # แสดงหน้า Login
  post '/login', to: 'sessions#create' # ตรวจสอบข้อมูล Login
  delete '/logout', to: 'sessions#destroy' # ลบ Session และออกจากระบบ

  # Posts, Comments, and Likes
  resources :posts do
    resources :comments, only: [:create, :destroy]
  
    member do
      post :like
    end
  end
  

  # Users
  resources :users, only: [:new, :create]
end
