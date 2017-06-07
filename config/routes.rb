Rails.application.routes.draw do

  resources :labels
  devise_for :users
  resources :notes, except: [:show, :new, :edit ]
	
  root :to => 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
