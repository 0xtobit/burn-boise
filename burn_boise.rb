require 'sinatra'
require 'httparty'
require 'nokogiri'
require 'erb'

get '/' do
  zipcode = "83704"
  url = "https://airnow.gov/index.cfm?action=airnow.local_city&zipcode=#{zipcode}&submit=Go"
  doc = HTTParty.get(url)
  parsed_page ||= Nokogiri::HTML(doc)
  aqi = parsed_page.css('.TblInvisible')[0].text[/\d+/].to_i

  # http://www2.deq.idaho.gov/air/AQIPublic/Ordinance/Index/3
  case aqi
  when 0..59
    background_color = 'green'
    message = 'Burn baby, burn!'
  when 60..73
    background_color = 'orange'
    message = "Maybe don't..."
  when 74..1000
    background_color = 'dark-red'
    message = "Nope."
  else
    background_color = 'white'
    message = "idk..."
  end

  erb File.open('erb/index.html.erb').read, locals: { aqi: aqi, background_color: background_color, message: message,
                                                      url: url}
end
