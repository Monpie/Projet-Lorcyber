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
  get 'droit' => 'droit#index'
  get 'plan' => 'plan_action_type#index'
  get 'plan' => 'plan_action_type#show'
  get 'societe', to: 'societe#index'
  get 'societe/show', to: 'societe#show'
  get 'societe/delete', to:  'societe#delete'

  get 'plan/show' => 'plan_action_type#show'
  post 'plan' => 'plan_action_type#create'

  post 'welcome/index' => 'welcome#connexion'

  post 'anomalie/show' => 'anomalie#alerte'
  post 'anomalie' => 'anomalie#create'
  post 'user/show' => 'user#edit'
  post 'societe/show' => 'societe#edit'
  post 'societe' => 'societe#create'
  post 'user' => 'user#create'
#  post 'user/edit' => 'user#edit'
#  post 'user/create' => 'user#create'
  post 'droit/create' => 'droit#create'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
