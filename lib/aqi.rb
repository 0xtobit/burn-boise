require 'httparty'
require 'nokogiri'
require 'pry'

def get_aqi(location)
  token = ENV["AQI_API_TOKEN"]
  url = "https://api.waqi.info/feed/#{location}/?token=#{token}"
  data = HTTParty.get(url)
  aqi = data["data"]["aqi"]
  [aqi, url]
end
