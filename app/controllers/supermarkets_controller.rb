class SupermarketsController < ApplicationController
  def map
    @supermarkets = Supermarket.all
    # The `geocoded` scope filters only flats with coordinates
    @markers = @supermarkets.geocoded.map do |supermarket|
      {
        lat: supermarket.latitude,
        lng: supermarket.longitude
      }
    end

    @custom_marker = {
      lat: 38.72615,
      lng: -9.14548,
      marker_html: render_to_string(partial: "marker")
    }
  end
end
