class PlatesController < ApplicationController
  def show

  end

  def get_plate
    @plates = Plate.where("ogc_fid = #{params[:id]}")
    @vulcanoes = Vulcano.vulc_on_plates(params[:id])

    # Vulcanos on plate
    @vulc_json= []
    @vulc_json << '['

    @vulcanoes.each.with_index do |c, index|
      @vulc_json << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@vulcanoes.size-1)
        @vulc_json << ','
      end
    end

    @vulc_json << ']'

    # Selected plate
    @plate_json= []
    @plate_json << '['

    @plates.each.with_index do |c, index|
      @plate_json << JSON[c.build_geojson.to_s.gsub('\n', '')]
      if index < (@plates.size-1)
        @plate_json << ','
      end
    end

    @plate_json << ']'

    render plates_show_path
  end
end
