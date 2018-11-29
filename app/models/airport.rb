class Airport < ApplicationRecord
  self.table_name = "airports"

  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "nameshort": "'+self.nameshort.to_s+'",
      "country": "'+self.country.to_s+'",
      "lat": "'+self.latitude.to_s+'",
      "lon": "'+self.longitude.to_s+'",
      "id": "'+self.id.to_s+'",
      "city": "'+self.city.to_s+'",
      "type": "'+self.apttype.to_s+'",
      "class": "'+self.aptclass.to_s+'",
      "status": "'+self.status.to_s+'",
      "color": "#005cf3"
    }
  }'
  end
end
