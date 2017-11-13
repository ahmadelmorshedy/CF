Rails.application.routes.draw do
  # Weather routes
  root :to => "weather#weather"
  get 'weather/get_weather' => 'weather#get_weather', as: :get_weather

  # Cities routes
  post 'country_cities_select' => "weather#country_cities_select"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
