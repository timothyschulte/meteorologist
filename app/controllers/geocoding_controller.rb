require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================


url = "https://maps.googleapis.com/maps/api/geocode/json?address=52+Fox+Run,+Centerville,+MA"
open(url).read
# raw_data = open(url).read
# parsed_data = JSON.parse(raw_data)


parsed_data = JSON.parse(open(url).read)
latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @latitude = latitude

    @longitude = longitude

    render("geocoding/street_to_coords.html.erb")
  end
end
