require 'rails_helper'

feature 'Weather', :weather do
  context 'Country/City weather' do
    scenario 'User can select Country/City to get weather', js: true do
      getWeatherData({country: 'Egypt', city: 'Aswan'})
    end

    scenario 'User can enter city name to get weather' do
      getWeatherData({city_name: 'Berlin'})
    end

    scenario 'User sees error message if entered wrong city name' do
      getWeatherData({city_name: 'Duckburg', false_data: true})
    end
  end

  context 'Location weather' do
    xscenario 'User can use his location to get weather', js: true do
      getWeatherData({user_location: true})
    end

    scenario 'User can use custom location to get weather' do
      getWeatherData({lon: 50, lat: 45})
    end

    scenario 'User sees error message if entered wrong coordinated' do
      getWeatherData({lon: 300, lat: 'Hello', false_data: true})
    end
  end
end