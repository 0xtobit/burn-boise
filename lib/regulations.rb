require 'set'
require './lib/aqi'

class Regulations
  Reactors = Set[:open, :fireplace, :woodstove, :certified]

  # http://www2.deq.idaho.gov/air/AQIPublic/Ordinance/Index/3
  Regulations = {
    "ada" => {60 => [:open], 74 => [:fireplace, :woodstove]},
    "boise" => {60 => [:open], 74 => [:fireplace, :woodstove, :certified]},
    "caldwell" => {60 => [:open]},
    "canyon" => {74 => [:open, :fireplace, :woodstove]},
    "eagle" => {60 => [:open], 74 => [:fireplace, :woodstove, :certified]},
    "garden city" => {60 => [:open], 74 => [:fireplace, :woodstove, :certified]},
    "greenleaf" => {60 => [:open]},
    "kuna" => {64 => [:open], 74 => [:fireplace, :woodstove]},
    "melba" => {},
    "meridian" => {60 => [:open], 74 => [:fireplace, :woodstove, :certified]},
    "middleton" => {60 => [:open]},
    "nampa" => {60 => [:open]},
    "parma" => {60 => [:open]},
    "star" => {60 => [:open], 74 => [:fireplace, :woodstove, :certified]},
    "wilder" => {}
  }

  def self.prohibited_reactors(location, aqi)
    prohibited = nil
    if Regulations.key?(location)
      prohibited = Set[]
      Regulations[location].each do | aqi_threshold, reactors |
        if aqi >= aqi_threshold
            prohibited.merge(reactors)
        end
      end
    end
    prohibited
  end

  def self.burn(location, reactor, aqi=nil)
    burn = nil
    if Regulations.key?(location) and Reactors.include?(reactor)
      aqi = aqi || get_aqi(location)
      prohibited = prohibited_reactors(location, aqi)
      burn = not(prohibited.include?(reactor))
    end
    burn
  end
end
