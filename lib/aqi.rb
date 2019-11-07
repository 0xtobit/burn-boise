require 'httparty'
require 'nokogiri'

def get_aqi(zipcode)
  url = "https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=#{zipcode}&submit=Go"
  doc = HTTParty.get(url)
  parsed_page ||= Nokogiri::HTML(doc)
  aqi = parsed_page.css('.TblInvisible')[0].text[/\d+/].to_i
  aqi
end
