TeeboxNetwork::Application.routes.draw do

  devise_for :users, controllers: { confirmations: "confirmations" }, path_names: { sign_in: "login", sign_out: "logout" }
  resources :users, only: [:show, :index]
  resources :signed_urls, only: :index
  
  root to: "questions#index"
  
  # Errors
  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }
  
  # Tags
  get "tagged/:tag", to: "questions#index", as: :tagged
  
  # Questions
  get "question_tags", to: "tags#question_tags", as: :question_tags #tokenInput json tags
  get "questions/unanswered", to: "questions#unanswered", as: :unanswered
  get "questions/popular", to: "questions#popular", as: :popular
  
  # Users
  get "users/:id/welcome", to: "users#welcome", as: :welcome
  get "users/:id/points", to: "points#index", as: :points
  get "users/:id/questions", to: "users#questions", as: :user_questions
  get "users/:id/answers", to: "users#answers", as: :user_answers
  get "users/:id/comments", to: "users#comments", as: :user_comments

  # Static
  get "how-it-works", to: "pages#info", as: :info
  get "sitemap", to: 'pages#sitemap', as: :sitemap
  get "about", to: 'pages#about', as: :about
  
  resources :points, only: :index
  
  resources :questions do
     resources :comments, except: [:edit, :update]
     member { post :vote }
   end
  
  resources :comments do 
    member { post :vote }
  end 
  
  resources :answers do 
    member { post :vote }
    member { put :correct }
    resources :comments, except: [:edit, :update]
  end
  
  resources :videos, except: [:edit, :update]
  resources :tags
  resources :activities, only: :index do
    member { put :read }
    collection do
      get 'notifications'
    end
  end
  
  resources :reports, only: [:index, :new, :create, :destroy] do
    collection do
      get "stats"
    end
  end
end
