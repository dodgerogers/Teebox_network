TeeboxNetwork::Application.routes.draw do

  devise_for :users, controllers: { confirmations: "confirmations" }, path_names: { sign_in: "login", sign_out: "logout" }
  resources :users, only: [:show, :index]
  resources :signed_urls, only: :index
  
  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }
  
  root to: "questions#index"
  
  get "tagged/:tag", to: "questions#index", as: :tagged
  
  get "question_tags", to: "tags#question_tags", as: :question_tags #tokenInput json tags
  get "questions/unanswered", to: "questions#unanswered", as: :unanswered
  get "questions/popular", to: "questions#popular", as: :popular
  
  get "users/:id/questions_index", to: "users#questions_index", as: :questions_index
  get "users/:id/answers_index", to: "users#answers_index", as: :answers_index
  get "users/:id/comments_index", to: "users#comments_index", as: :comments_index
  get "users/:id/welcome", to: "users#welcome", as: :welcome

  get "pages/info", to: "pages#info", as: :info
  
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
