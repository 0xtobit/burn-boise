require 'sinatra'
require 'erb'
require './lib/aqi'
require './lib/regulations'

get '/' do
  zipcode = params[:zipcode] || "83704"
  aqi = get_aqi(zipcode)

  prohibited = Regulations.prohibited_reactors(zipcode, aqi)

  if prohibited.nil?
    background_color = 'gray'
    message = "idk..."
  elsif prohibited.empty?
    background_color = 'green'
    message = 'Burn baby, burn!'
  elsif prohibited < Regulations::Reactors
    background_color = 'orange'
    message = "Maybe don't..."
  else
    background_color = 'dark-red'
    message = "Nope."
  end

  erb File.open('erb/index.html.erb').read, locals: { aqi: aqi, background_color: background_color, message: message,
                                                      url: url}
end

get '/aqi/:zipcode' do
  content_type :json
  get_aqi(params[:zipcode]).to_json
end

get '/burn/:zipcode/:reactor' do
  zipcode = params[:zipcode]
  reactor = params[:reactor].to_sym
  burn = Regulations.burn(zipcode, reactor)
  content_type :json
  burn.to_json
end
