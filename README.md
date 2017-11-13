# README

### Coding Challenge 

### Running the App
* cd to app directory
* bundle install (Note: I use rvm with .ruby-version & .ruby-gemset)
* ruby-version: 2.4.2
* run the server
* visit root path
* That's it - everything is clear enough

### Notes
* I used an already built basic app, don't worry if you found older useless commits/branches
* I have added the ability to user to enter wrong data/city names as it was required to handle input errors, that's why for example, you can find ability of entering custom city name in text field 
* openweathermap key, and also number of minutes to cache, can be found / changed in environment file

### Future Enhancemnts
* openweathermap have already their list of cities in a JSON file, we can make a task that parses this file, saves all cities in Redis, along with their ids and country, so that 
  1. validating city existence can be done in our side instead of calling the API each time
  2. We provide a matching cities list to the user from step 1 (for example, I used a gem that have 'Al Iskandriyah' to name my city, which is right using Arabic-like pronouncation, but it's called Alexandria in openweathermap data