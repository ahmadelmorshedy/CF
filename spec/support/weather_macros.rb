module WeatherMacros
  # internal methods

  def select_country_city(country, city)
    click_on I18n.t('weather_form.country_city_select')
    select country, from: "country"
    select city, from: "city"
  end

  def enter_city_name(city_name)
    click_on I18n.t('weather_form.city_name')
    fill_in "city_name", with: city_name
  end

  def user_location()
    click_on I18n.t('location')
    check "user_location"
  end

  def custom_location(lon, lat)
    click_on I18n.t('location')
    fill_in "lon", with: lon
    fill_in "lat", with: lat
  end

  ##############################################################################

  # Main method - used by spec/features/weather_spec.rb tests
  def getWeatherData(options)
    visit root_path
    expect(page).to have_text I18n.t('main_title')
    # fill in form-data
    if options[:country] && options[:city]
      select_country_city(options[:country], options[:city])
    elsif options[:city_name]
      enter_city_name(options[:city_name])
    elsif options[:user_location]
      user_location()
    elsif options[:lon] && options[:lat]
      custom_location(options[:lon], options[:lat])
    end
    # submit
    click_button I18n.t('weather_form.submit')
    # Expect
    unless options[:false_data]
      expect(page).to have_text I18n.t('weather_data.temperature')
      expect(page).to have_text I18n.t('weather_data.wind_speed')
    else
      expect(page).to have_text I18n.t('weather_invalid_call')
      expect(page).not_to have_text I18n.t('weather_data.temperature')
    end
  end
end