class Vulcano < ApplicationRecord
  self.table_name = "vulcanoes"

  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "name": "'+self.name_+'",
      "location": "'+self.location+'",
      "lat": "'+self.lat.to_s+'",
      "lon": "'+self.lon.to_s+'",
      "id": "'+self.id.to_s+'",
      "elev": "'+self.elev.to_s+'",
      "type": "'+self.type_+'",
      "status": "'+self.status+'",
      "time_frame": "'+self.time_frame+'",
      "color": "#fc4353",
      "size": "'+self.size(self.elev).to_s+'"

    }
  }'
  end

  def size(elev)
    # Return a case.
    return case elev
           when 0..500 then 5
           when 500..1000 then 10
           when 1000..3000 then 15
           when 3000..99999999 then 20
           else "Invalid"
           end
  end

end
