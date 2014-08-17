Cs61asQuizzes::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :users, only: [:edit, :update]

  namespace 'staffs' do
    get '/staff_dashboard', to: 'dashboard#index', as: :dashboard

    resources :grades do
      collection do
        post :download
      end
    end

    resources :questions, except: :show do
      member do
        post :add
      end

      collection do
        get :bank
        get :download
      end
    end

    resources :quiz_requests, only: [:index, :destroy] do
      member do
        post :approve
      end
    end

    resources :students, only: [:index, :show] do
      collection do
        get :import
        post :submit_import
        get :download_initial_passwords
      end

      scope module: 'students' do
        resources :quizzes, only: :show do
          put :finish_grading
        end
      end
    end

    resources :taken_quizzes, only: [:update]

    resources :regrades, only: :destroy

    resources :quizzes do
      resource :relationships, only: :destroy

      member do
        get :stats
      end
    end
  end

  namespace 'students' do
    get '/student_dashboard', to: 'dashboard#index', as: :dashboard

    resources :regrades, only: :create

    resources :quizzes, only: [:take, :show] do
      member do
        post :submit
      end

      collection do
        get :take
        post :make_request
      end
    end

    resources :quiz_locks, only: [:lock, :unlock] do
      member do
        post :lock
        patch :unlock
      end
    end

    resources :quiz_requests, only: :destroy
  end
end
