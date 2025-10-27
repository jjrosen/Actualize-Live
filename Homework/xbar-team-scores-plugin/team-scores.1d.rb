#!/usr/bin/env ruby
require "http"

response = HTTP.get("https://www.thesportsdb.com/api/v1/json/123/eventsnext.php?id=134936")
data_nfl = response.parse
time_nfl = data_nfl["events"][0]["strTime"]
week = data_nfl["events"][0]["intRound"]
event_nfl = data_nfl["events"][0]["strEvent"]
puts "Week #{week}: #{event_nfl} will start at #{time_nfl} EST."

response = HTTP.get("https://www.thesportsdb.com/api/v1/json/123/eventsnext.php?id=134863")
data_nba = response.parse
event_nba = data_nba["events"][0]["strEvent"]
time_nba = data_nba["events"][0]["strTimeLocal"]
puts "#{event_nba} will start at #{time_nba} EST"
#phillies = 135276
#i am getting errors for xbar and i dont know what the problen is
