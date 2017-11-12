module WeatherMacros
  # internal methods

  def select_country_city(country, city)
    click "country_city-tab"
    select country, from: "country"
    select city, from: "city"
  end

  def enter_city_name(city_name)
    click "city_name-tab"
    fill_in "city_name", with: city_name
  end

  def user_location()
    click "location-tab"
    check "my_location"
  end

  def custom_location(lon, lat)
    click "location-tab"
    fill_in "longitude", with: lon
    fill_in "latitude", with: lat
  end

  ##############################################################################

  # Main method - used by spec/features/weather_spec.rb tests
  def getWeatherData(options)
    visit root_path
    expect(page).to have_text 'SOME TITLE HERE'
    # fill in form-data
    if options[:country] && options[:city]
      select_country_city(options[:country], options[:city])
    elsif options[:city_name]
      enter_city_name(options[:city_name])
    elsif options[:user_location]
      user_location()
    elsif options[:lon] && options[:lat]
      custom_location(lon, lat)
    end
    # submit
    click_button 'SUBMIT BUTTON'
    # Expect
    unless options[:false_data]
      expect(page).to have_text 'TEMPERATURE_TEXT'
      expect(page).to have_text 'WIND_TEXT'
    else
      expect(page).to have_text I18n.t('weather_invalid_call')
      expect(page).not_to have_text 'TEMPERATURE_TEXT'
    end
  end
end