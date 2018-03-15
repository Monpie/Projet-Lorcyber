Rails.application.routes.draw do

  get 'welcome/index'

  root 'welcome#index'

  get 'anomalie', to: 'anomalie#index'
  get 'anomalie/show', to: 'anomalie#show'

# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
