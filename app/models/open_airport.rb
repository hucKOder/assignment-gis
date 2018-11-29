class OpenAirport < ApplicationRecord
  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "name": "'+self.name+'",
      "country": "'+self.country+'",
      "id": "'+self.id.to_s+'",
      "city": "'+self.city+'",
      "faa": "'+self.faa+'",
      "color": "#005cf3"
    }
  }'
  end
end
