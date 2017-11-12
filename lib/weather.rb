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
  def getWeather(options)
    # initialize request
    req = "http://api.openweathermap.org/data/2.5/weather?"
    # append data
    if options[:city].present?
      req += "q=#{options[:city]}"
    elsif options[:lon] && options[:lat]
      # validate values
      if validate_coordinates?(options[:lon], options[:lat])
        req += "lat=#{options[:lat]}&lon=#{options[:lon]}"
      else
        return "Invalid Call - invalid parameters"
      end
    else
      # Invalid Call
      return "Invalid Call - use {city: CITY_NAME} or {lon:X,lat:Y} as parameters"
    end
    # Append metric unit options adn APPID
    req += "&units=metric&APPID=#{WEATHERMAP_APPID}"
    # Send api call
    weather_response = HTTParty.get req
    # handle response
    if weather_response.code == 200
      return weather_response.parsed_response["main"]["temp"]
    else
      return "Invalid Call - #{weather_response.parsed_response['message']}"
    end
  end
end