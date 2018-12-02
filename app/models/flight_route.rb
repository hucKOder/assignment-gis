class FlightRoute < ApplicationRecord
  self.table_name = 'flight_routes'

  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "id": "'+self.ogc_fid.to_s+'",
      "src": "'+self.src+'",
      "dest": "'+self.dst+'",
      "color": "#005cf3"
    }
  }'
  end

  def self.get_routes(src_id)
    FlightRoute.find_by_sql("
    SELECT DISTINCT ON (route.wkb_geometry) *
    FROM flight_routes route
    WHERE route.src_id = '#{src_id}';
    ")
  end

  def self.get_closest_vulcanoes(route_id, distance)
    Vulcano.find_by_sql("
    SELECT vulc.*, ST_Distance(route.wkb_geometry::geography, vulc.wkb_geometry::geography) / 1000 AS distance_km
FROM flight_routes route, vulcanoes vulc
WHERE route.ogc_fid= #{route_id} AND ST_DWithin(route.wkb_geometry::geography, vulc.wkb_geometry::geography, #{distance} * 1000)
    ")
  end

end
