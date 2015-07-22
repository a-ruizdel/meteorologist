require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

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

    render("coords_to_weather.html.erb")
  end
end
