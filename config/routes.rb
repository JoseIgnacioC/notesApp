Rails.application.routes.draw do

  
  resources :labels, except: [:index, :show, :new, :edit]
  devise_for :users
  
  resources :notes, except: [:edit, :new ] do
  	resources :commenters
  end
	
  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
