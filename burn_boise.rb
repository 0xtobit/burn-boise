require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'erb'

get '/' do
  zipcode = "83704"
  doc = HTTParty.get("https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=#{zipcode}&submit=Go")
  parsed_page ||= Nokogiri::HTML(doc)
  aqi = parsed_page.css('.TblInvisible')[0].text[/\d+/].to_i
  erb File.open('erb/index.html.erb').read, locals: { aqi: aqi }
end
