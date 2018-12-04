Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => redirect('/map/show')
  get 'map/show'
  get 'map/search'
  get 'map/vulcanoes_near_route'
  get 'plates/get_plate'
  get 'plates/show'
  post 'plates/show'
end
