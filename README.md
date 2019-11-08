# Burn Boise

A simple Sinatra app that takes the [Air Quality Index (AQI)](https://airnow.gov/) and compares it with [Boise local ordinances](http://www2.deq.idaho.gov/air/AQIPublic/Ordinance/Index/3) to let you know whether current conditions are within ordinances based off of forecasts.

DISCLAIMER: Official restrictions are served [here](http://www2.deq.idaho.gov/air/AQIPublic/Forecast?siteId=14). *Furthermore, prohibitions are based off of the forecast, not actual conditions.* That is, an AQI lower than forecase does not necessarily mean it is okay for you to burn. For more information on open burning requirements, please contact your local city or county office.

## Usage

burn-boise.raff.io selfishly defaults to my zipcode (83704), but you may provide a zipcode as argument: http://burn-boise.raff.io/?zipcode=83702.

### API Endpoints

For simple responses, designed to be consumed by other apps, try:

* http://burn-boise.raff.io/aqi/83702
* http://burn-boise.raff.io/burn/83702/open
  * Try `open`, `fireplace`, `woodstove`, or `certified` for your specific question.
  * [List of parseable regulations](https://github.com/0xtobit/burn-boise/blob/master/lib/regulations.rb#L9)

## Requirements
* Ruby 2.6.4
* Sinatra
* HTTParty
* Nokogiri

## Contributing
Happy to look at pull requests introducing new features.

1. Fork it
2. Create a topic branch
3. Commit
4. Open Pull Request
