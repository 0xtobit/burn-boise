require 'sinatra'
require 'httparty'
require 'nokogiri'

get '/' do
  doc = HTTParty.get('https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=83704&submit=Go')
  parsed_page ||= Nokogiri::HTML(doc)
  parsed_page.css('.TblInvisible')[0].text[/\d+/] # .to_i
end
