require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    url= "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    parsed_data = JSON.parse(open(url).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url = "https://api.forecast.io/forecast/41f73306c5622f30ce59b676f5f07ed9/#{@lat},#{@lng}"

    parsed_data = JSON.parse(open(url).read)
    temperature = parsed_data["currently"]["temperature"]
    summary = parsed_data["currently"]["summary"]
    summary_sixty = parsed_data["minutely"]["summary"]
    summary_hours = parsed_data["hourly"]["summary"]
    summary_daily = parsed_data["daily"]["summary"]

    @current_temperature = temperature

    @current_summary = summary

    @summary_of_next_sixty_minutes = summary_sixty

    @summary_of_next_several_hours = summary_hours

    @summary_of_next_several_days = summary_daily


    render("street_to_weather.html.erb")
  end
end
