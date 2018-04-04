Rails.application.routes.draw do

  get 'welcome/index'
  root 'welcome#index'

  get 'welcome/deconnexion', to: 'welcome#deconnexion'
  get 'anomalie', to: 'anomalie#index'
  get 'anomalie/show', to: 'anomalie#show'
  post 'welcome/index' => 'welcome#connexion'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
