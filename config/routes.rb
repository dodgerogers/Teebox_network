TeeboxNetwork::Application.routes.draw do
    
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
  get "/users/:id/breakdown", to: 'points#breakdown', as: :breakdown

  # Static
  get "how-it-works", to: "pages#info", as: :info
  get "sitemap", to: 'pages#sitemap', as: :sitemap
  get "about", to: 'pages#about', as: :about
  get "/terms-and-conditions", to: 'pages#terms', as: :terms
  
  devise_for :users, controllers: { confirmations: "confirmations" }, path_names: { sign_in: "login", sign_out: "logout" }
  resources :users, only: [:show, :index]
  resources :signed_urls, only: :index
  
  # AWS End point for SNS
  post "/aws/end_point", to: 'aws_notifications#end_point', as: :end_point
  
  # Points
  resources :points, only: :index
  resources :questions do
    resources :comments, except: [:edit, :update]
    member do
      get "related"
    end
  end
  
  # Comments
  resources :comments, except: [:edit, :update, :new, :create, :destroy, :index]
  
  # Answers
  resources :answers, except: :index do 
    member { put :correct }
    resources :comments, except: [:edit, :update]
  end
  
  # Videos
  resources :videos, except: [:edit, :update]
  
  # Tags
  resources :tags
  
  # Notifications/Activities
  resources :activities, only: :index do
    #member { put :read }
    member { get :read }
    collection { get 'notifications' }
  end
  
  # Reports
  resources :reports, only: [:index, :new, :create, :destroy] do
    collection { get "stats" }
  end
  
  # Votes
  resources :votes, only: [:create, :new]
  
  if Rails.env.development?
    mount MailPreview => "mail_view"
  end
end
