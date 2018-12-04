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
    @airports = []
    @flight_route = FlightRoute.get_routes(params[:src_id])

    # If there is a route between the airports
    if @flight_route != []
      @airports = OpenAirport.get_direct_airports(params[:src_id])
    else
      @airports = OpenAirport.where("identif = '#{params[:src_id]}'")
    end

    # Closest vulcanoes to the airport
    @vulcanoes = OpenAirport.get_closest_vulcanoes(params[:src_id], params[:vulc_dist])

    # Find route between selected airports
    @geojson_route = []
    @geojson_route << '['
    @flight_route.each { |c| @geojson_route << JSON[c.build_geojson.to_s.gsub('\n', '')] }
    @geojson_route << ']'

    # Get closest vulcanoes JSON
    @geojson_vulcanoes= []
    @geojson_vulcanoes << '['
    @vulcanoes.each.with_index do |c, index|
      @geojson_vulcanoes << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@vulcanoes.size-1)
        @geojson_vulcanoes << ','
      end
    end
    @geojson_vulcanoes << ']'

    # Get src and dst airports JSON
    @geojson_airports= []
    @geojson_airports<< '['
    @airports.each.with_index do |c, index|
      @geojson_airports << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@airports.size-1)
        @geojson_airports << ','
      end
    end
    @geojson_airports << ']'

    render map_show_path
  end

  def vulcanoes_near_route
    @near_vulcanoes = FlightRoute.get_closest_vulcanoes(params[:route_id], params[:distance])

    @json_vulcanoes= []
    @json_vulcanoes << '['

    @near_vulcanoes.each.with_index do |c, index|
      @json_vulcanoes << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@near_vulcanoes.size-1)
        @json_vulcanoes << ','
      end
    end

    @json_vulcanoes << ']'

    respond_to do |format|
      format.html
      format.json { render json: @json_vulcanoes }  # respond with the created JSON object
    end
  end
end
