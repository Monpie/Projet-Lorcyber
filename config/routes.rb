Rails.application.routes.draw do

  get 'welcome/index'
  root 'welcome#index'

  get 'welcome/deconnexion', to: 'welcome#deconnexion'
  get 'anomalie', to: 'anomalie#index'
  get 'anomalie/show', to: 'anomalie#show'
  get 'anomalie/delete', to:  'anomalie#delete'
  get 'user/delete' => 'user#delete'
  get 'user' => 'user#index'
  get 'user/show' => 'user#show'

  post 'welcome/index' => 'welcome#connexion'
  post 'anomalie/show' => 'anomalie#alerte'
  post 'anomalie/create' => 'anomalie#create'
  post 'user/edit' => 'user#edit'
  post 'user/create' => 'user#create'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
