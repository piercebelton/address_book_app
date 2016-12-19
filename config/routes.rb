Rails.application.routes.draw do
  get '/contacts/index'
  post '/contacts/index'
  post '/contacts/update' => 'contacts#update'
  post '/contacts/destroy' => 'contacts#destroy'
  post '/contacts/add' => 'contacts#add'
  post '/contacts/show' => 'contacts#show'
  get '/contacts/sort' => 'contacts#sort'
  root 'contacts#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
