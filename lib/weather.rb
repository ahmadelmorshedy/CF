module Weather
  # Validates longitude and latitude passed to getWeather function
  # 
  # @param lon [Float] longitude
  # @param lat [Float] latitude
  # @return [Boolean] true if valid coordinates, false otherwise
  def validate_coordinates?(lon, lat)
    (lon.abs <= 180 && lat.abs <= 90)? true : false
  end

  # gets Current Weather from http://openweathermap.org for given city using 
  # city name or long/lat
  # 
  # retrun [Hash] hash of weather info
  def getWeather(options)
    # initialize request
    req = "http://api.openweathermap.org/data/2.5/weather?"
    # append data
    if options && options[:city]
      req += "q=#{options[:city]}"
    elsif options && options[:lon] && options[:lat]
      # validate values
      if validate_coordinates?(options[:lon], options[:lat])
        req += "lat=#{options[:lat]}&lon=#{options[:lon]}"
      else
        return {error_message: "#{I18n.t('weather_invalid_call')} - #{I18n.t('weather_invalid_parameters')}"}
      end
    else
      # Invalid Call
      return {error_message: "#{I18n.t('weather_invalid_call')} - #{I18n.t('weather_wrong_parameters')}"}
    end
    # Append metric unit options adn APPID
    req += "&units=metric&APPID=#{WEATHERMAP_APPID}"
    # Send api call
    weather_response = HTTParty.get req
    # handle response
    if weather_response.code == 200
      weather = {}
      parsed_resp = weather_response.parsed_response
      weather[:city] = parsed_resp["name"]
      weather[:desc] = parsed_resp["weather"][0]["description"].capitalize # weather status
      # city coordinates
      weather[:lon] = parsed_resp["coord"]["lon"]
      weather[:lat] = parsed_resp["coord"]["lat"]
      # weather
      weather[:temp] = parsed_resp["main"]["temp"]
      weather[:temp_min] = parsed_resp["main"]["temp_min"]
      weather[:temp_high] = parsed_resp["main"]["temp_max"]
      weather[:pressure] = parsed_resp["main"]["pressure"]
      weather[:humidity] = parsed_resp["main"]["humidity"]
      # wind
      weather[:wind_speed] = parsed_resp["wind"]["speed"]
      weather[:wind_degree] = parsed_resp["wind"]["deg"]

      return weather
    else
      return {error_message: "#{I18n.t('weather_invalid_call')} - #{weather_response.parsed_response['message']}"}
    end
  end
end