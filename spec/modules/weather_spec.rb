require 'rails_helper'
include Weather

describe Weather do
  # Getting Weather by City Name

  it "gets Weather by Country/City name" do
    expect(getWeather({city: 'London'})[:temp].class.name).to eq "Float"
  end

  it "returns error_message if country/city name not found" do
    expect(getWeather({city: 'Xanadu'})[:error_message].include?("#{I18n.t('weather_invalid_call')} -")).to be true 
  end

  ##############################################################################

  # Getting Weather by long/lat

  it "gets Weather by longitude/latitude" do
    expect(getWeather({lon: 50, lat: 50})[:temp].class.name).to eq "Float"
  end

  it "returns error_message if longitude/latitude not found" do
    expect(getWeather({lon: 210, lat: 270})[:error_message]).to eq "#{I18n.t('weather_invalid_call')} - #{I18n.t('weather_invalid_parameters')}"
  end

  ##############################################################################

end
