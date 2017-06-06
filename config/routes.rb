Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'welcome#index'

get 'sessions/new'

get '/', to: 'welcome#index', as: 'home'

get('/contact', { to: 'welcome#contact'})

post('/contact_submit', { to: 'welcome#submit' })

resources :ideas

resources :ideas do
  resources :reviews, only: [:show, :new, :create, :edit, :destroy]
end

  resources :sessions, only: [:new, :create, :edit] do
    # when you define a route with 'on: :collection' option, it skips requiring an :id
    delete :destroy, on: :collection
  end

  resources :users
  resources :welcome
  resources :reviews


  # resources :ideas do
  #   resources :answers, only: [:create, :destroy]
  #   #adds the following nested routes:
  #   #/questions/:question_id/answers VERB: post
  #   #/questions/:question_id/answers/:id VERB: delete
  # end


end
