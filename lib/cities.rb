module Cities
  def country_cities(country_code)
    country = ISO3166::Country.new(country_code)
    # get states
    states = country.states # Hash
    cities = []
    states.keys.each do |state_key|
      state = states[state_key]
      cities << state.name
    end
    return cities
  end
end