# require 'http'

# response = HTTP.get("https://data.sfgov.org/resource/jjew-r69b.json")

# pp response.parse

# require 'httparty'
# response = HTTParty.get("https://data.sfgov.org/resource/jjew-r69b.json")


# responses = response.parsed_response

# # pp responses[0]

# index = 0

# responses.each do |response|
#   @applicant = response["applicant"]
#   @location = response["location"]
#   @latitude = response["latitude"]
#   @longitude = response["longitude"]
#   @x = []
#   @x.push(@applicant, @location, @latitude, @longitude)
# end
# pp @x





require 'httparty'
response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=philadelphia&units=imperial&appid=#{ENV["OPEN_WEATHER_API_KEY"]}")


responses = response.parsed_response

pp responses

# Hide your api keys
# Open up the .zshrc
# code ~/.zshrc
# Add the export to your API Key into the last line of your .zshrc
# export OPEN_WEATHER_API_KEY=79a3eb2ad76d015b5a67a3bf7607634f
# Go back to your ruby file and update the appid section to use the following:
# #{ENV["OPEN_WEATHER_API_KEY"} instead of the hardcoded api key
# To verify it's there you can run printenv and you should see your exported apikey
