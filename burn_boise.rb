require 'sinatra'
require 'erb'
require './lib/aqi'
require './lib/regulations'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

get '/' do
  location = params[:location] || "boise"
  aqi, _url = get_aqi(location)

  prohibited = Regulations.prohibited_reactors(location, aqi)

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

  erb File.open('erb/index.html.erb').read, locals: { aqi: aqi, background_color: background_color, message: message }
end

get '/aqi/:location' do
  content_type :json
  get_aqi(params[:location]).to_json
end

get '/burn/:location/:reactor' do
  location = params[:location]
  reactor = params[:reactor].to_sym
  burn = Regulations.burn(location, reactor)
  content_type :json
  burn.to_json
end
