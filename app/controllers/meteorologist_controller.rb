require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ", "+")
open(url).read

parsed_data = JSON.parse(open(url).read)
latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    # @latitude = latitude
    # @longitude = longitude

url = "https://api.darksky.net/forecast/389c3b3d091ca54161e5e258e6d6eea1/" + latitude.to_s + "," + longitude.to_s
open(url).read
parsed_data = JSON.parse(open(url).read)

current_temperature = parsed_data["currently"]["temperature"]
current_summary = parsed_data["currently"]["summary"]
summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
summary_of_next_several_hours = parsed_data["hourly"]["summary"]
summary_of_next_several_days = parsed_data["daily"]["summary"]

    @current_temperature = current_temperature
    @current_summary = current_summary
    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes
    @summary_of_next_several_hours = summary_of_next_several_hours
    @summary_of_next_several_days = summary_of_next_several_days

    render("meteorologist/street_to_weather.html.erb")
  end
end


# instance variable starts w/ @...readable from controller to an html file...these are what appear w/in the html file
# local variable doesn't start w/ @...can only access at that exact point...wouldn't show up on the html file