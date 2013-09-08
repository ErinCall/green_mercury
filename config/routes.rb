GreenMercury::Application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root 'index#index'
  get '/time_tracking', controller: :time_tracking, action: :index
  post '/time_tracking', controller: :time_tracking, action: :track
  put '/time_tracking.:id', controller: :time_tracking, action: :edit, as: :volunteer_block
  get '/events', controller: :events, action: :index
  post '/events/rsvp/:id', controller: :events, action: :rsvp, as: :event_rsvp
  get '/events/get_token', controller: :events
end
