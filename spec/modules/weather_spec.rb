describe Weather do
  # include Module
  include Weather

  it "gets Weather by Country/City name" do
    expect(getWeather({city: 'London'}).class.name).to eq "Integer"
  end

  it "returns error_message if country/city name not found" do
    expect(getWeather({city: 'Aldorado'})).to eq "Some Error Message Here"
  end

  it "gets Weather by longitude/latitude" do
    expect(getWeather({long: 50, lat: 50}).class.name).to eq "Integer"
  end

  it "returns error_message if longitude/latitude not found" do
    expect(getWeather({long: 210, lat: 270})).to eq "Some Error Message Here"
  end
end