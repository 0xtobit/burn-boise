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

  Zipcodes = {
    "83605" => ["caldwell", "canyon"],
    "83607" => ["caldwell", "canyon"],
    "83626" => ["greenleaf", "canyon"],
    "83641" => ["melba", "canyon"],
    "83644" => ["middleton", "canyon"],
    "83651" => ["nampa", "canyon"],
    "83660" => ["parma", "canyon"],
    "83676" => ["wilder", "canyon"],
    "83686" => ["nampa", "canyon"],
    "83687" => ["nampa", "canyon"],
    "83616" => ["eagle", "ada"],
    "83634" => ["kuna", "ada"],
    "83642" => ["meridian", "ada"],
    "83646" => ["star", "ada"],
    "83702" => ["boise", "ada"],
    "83703" => ["boise", "ada"],
    "83704" => ["boise", "ada"],
    "83705" => ["boise", "ada"],
    "83706" => ["boise", "ada"],
    "83708" => ["boise", "ada"],
    "83709" => ["boise", "ada"],
    "83712" => ["boise", "ada"],
    "83713" => ["boise", "ada"],
    "83714" => ["garden city", "ada"],
    "83716" => ["boise", "ada"],
    "83720" => ["boise", "ada"],
    "83722" => ["boise", "ada"],
    "83724" => ["boise", "ada"],
    "83725" => ["boise", "ada"],
    "83726" => ["boise", "ada"],
    "83728" => ["boise", "ada"],
    "83729" => ["boise", "ada"],
    "83732" => ["boise", "ada"],
    "83735" => ["boise", "ada"],
    "83756" => ["boise", "ada"]
  }

  def self.prohibited_reactors(zipcode, aqi)
    prohibited = nil
    if Zipcodes.key?(zipcode)
      prohibited = Set[]
      for regulation_key in Zipcodes[zipcode]
        Regulations[regulation_key].each do | aqi_threshold, reactors |
          if aqi >= aqi_threshold
              prohibited.merge(reactors)
          end
        end
      end
    end
    prohibited
  end

  def self.burn(zipcode, reactor, aqi=nil)
    burn = nil
    if Zipcodes.key?(zipcode) and Reactors.include?(reactor)
      aqi = aqi || get_aqi(zipcode)
      prohibited = prohibited_reactors(zipcode, aqi)
      burn = not(prohibited.include?(reactor))
    end
    burn
  end
end
