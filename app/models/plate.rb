class Plate < ApplicationRecord
  def build_geojson
    geojson =  '{
    "type": "Feature",
    "geometry": '+RGeo::GeoJSON.encode(self.wkb_geometry).to_s.gsub('=>' , ':') +',
    "properties": {
      "platename": "'+self.platename+'",
      "id": "'+self.ogc_fid.to_s+'",
      "color": "#fc4353"
    }
  }'
  end
end
