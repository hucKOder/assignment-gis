class MapController < ApplicationController
  def show
    @vulcanoes = Vulcano.all.limit(100)
    @airports = OpenAirport.all.limit(100)

    @geojson_vulcanoes= []
    @geojson_vulcanoes << '['
    @vulcanoes.each.with_index do |c, index|
      @geojson_vulcanoes << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@vulcanoes.size-1)
        @geojson_vulcanoes << ','
      end
    end
    @geojson_vulcanoes << ']'

    @geojson_airports= []
    @geojson_airports<< '['
    @airports.each.with_index do |c, index|
      @geojson_airports << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@airports.size-1)
        @geojson_airports << ','
      end
    end
    @geojson_airports << ']'
    end

  def search

  end

end
