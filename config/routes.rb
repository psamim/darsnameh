Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount Ckeditor::Engine => '/ckeditor'

  root 'access#welcome'
  get  '/login', to: 'access#login', as: :login
  match '/login', to: 'access#attempt_login', via: [:post]
  match '/logout', to: 'access#logout', via: [:post, :get], as: :logout
  match '/password', to: 'admin#change_password', via: [:post, :get], as: :change_password
  get 'quiz/:secret' => 'quiz#show', as: :quiz
  match 'quiz', to: 'quiz#result', via: [:post, :get]
  match 'email', to: 'mail_reciever#on_incoming_email', via: [:post, :get]

  resources :courses do
    resources :lessons do
    end
  end

  resources :lessons, except: :index do
    resources :questions
  end

  resources :questions, except: :index

end
