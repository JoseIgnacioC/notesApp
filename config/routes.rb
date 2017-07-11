Rails.application.routes.draw do

  post 'notes/diHola', to: "notes#diHola"
  get 'notes/filter_labels/:id', to: "notes#filter_labels"

  resources :labels, except: [:index, :show, :new, :edit]
  devise_for :users
  
  resources :notes, except: [:show, :new ] do
  	resources :commenters
  end
	
  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
