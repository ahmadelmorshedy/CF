require './lib/weather.rb'
require './lib/cities.rb'
class WeatherController < ApplicationController
  include Weather
  include Cities

  def weather
  end

  def get_weather
    # prepare options
    options = {}

    options[:city] = params[:city_name] if params[:city_name].present?
    if params[:country].present? && params[:city].present?
      options[:city] = params[:city]
    end
    if params[:lon].present? && params[:lat].present?
      options[:lon] = params[:lon]
      options[:lat] = params[:lat]
    end

    unless options.empty?
      weather = getWeather(options)

      unless weather[:error_message]
        @city = weather[:city] # city name
        @desc = weather[:desc] # weather status
        # city coordinates
        @lon = weather[:lon]
        @lat = weather[:lat]
        # weather
        @temp = weather[:temp]
        @temp_min = weather[:temp_min]
        @temp_high = weather[:temp_min]
        @pressure = weather[:pressure]
        @humidity = weather[:humidity]
        # wind
        @wind_speed = weather[:wind_speed]
        @wind_degree = weather[:wind_degree]

        # render weather
        render :weather
      else
        flash[:error] = weather[:error_message]
        redirect_to root_path  
      end
    else
      flash[:error] = "#{I18n.t('Invalid call')} - #{I18n.t('weather_invalid_parameters')}"
      redirect_to root_path
    end
  end

  def country_cities_select
    @cities = country_cities(params[:country_code])
    render partial: 'cities'
  end
end
