class OpenAirport < ApplicationRecord
  self.table_name = 'open_airports'

  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "id": "'+self.id.to_s+'",
      "name": "'+self.name+'",
      "country": "'+self.country+'",
      "city": "'+self.city+'",
      "faa": "'+self.faa+'",
      "color": "#005cf3"
    }
  }'
  end

  def self.get_closest_vulcanoes(airport_id, distance)
    Vulcano.find_by_sql("
    SELECT v.*, ST_Distance(a.wkb_geometry::geography, v.wkb_geometry::geography) / 1000 AS distance_km
FROM vulcanoes v, open_airports a
WHERE a.identif = '#{airport_id}' AND ST_DWithin(a.wkb_geometry::geography, v.wkb_geometry::geography, #{distance} * 1000);
    ")
  end

  # Includes src airport
  def self.get_direct_airports(airport_id)
    OpenAirport.find_by_sql("SELECT ogc_fid, identif, name, country, city, faa, wkb_geometry FROM open_airports
	WHERE identif = '#{airport_id}'
UNION
 SELECT ogc_fid, identif, name, country, city, faa, wkb_geometry FROM open_airports o
 JOIN
	(SELECT dst_id
	FROM flight_routes route
	WHERE route.src_id = '#{airport_id}') x
    ON o.identif = x.dst_id
")
  end
end
