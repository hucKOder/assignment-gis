class CreateDatabase < ActiveRecord::Migration[5.2]
  def change
    create_table "airports", primary_key: "ogc_fid", id: :serial, force: :cascade do |t|
      t.string "id"
      t.string "nameshort"
      t.string "namelong"
      t.string "namealt"
      t.string "city"
      t.string "icao"
      t.string "iata"
      t.string "apttype"
      t.string "aptclass"
      t.string "authority"
      t.string "status"
      t.string "dmg"
      t.string "rwpaved"
      t.integer "rwlengthm"
      t.integer "rwlengthf"
      t.integer "elevm"
      t.integer "elevf"
      t.string "humuse"
      t.string "humoperatedby"
      t.string "locprecision"
      t.float "latitude"
      t.float "longitude"
      t.string "iso3"
      t.string "iso3_op"
      t.string "country"
      t.datetime "lastcheckdate"
      t.string "remarks"
      t.string "url_lca"
      t.string "source"
      t.datetime "createdate"
      t.datetime "updatedate"
      t.integer "geonameid"
      t.string "gdb_geomattr_data"
      t.integer "rwwidthm"
      t.string "shape"
      t.geometry "wkb_geometry", limit: {:srid=>4326, :type=>"st_point"}
      t.index ["wkb_geometry"], name: "airports_wkb_geometry_geom_idx", using: :gist
    end

    create_table "flight_routes", primary_key: "ogc_fid", id: :serial, force: :cascade do |t|
      t.string "airline"
      t.string "airline_id"
      t.string "src"
      t.string "src_id"
      t.string "dst"
      t.string "dst_id"
      t.string "codeshare"
      t.string "stops"
      t.string "equipment"
      t.geometry "wkb_geometry", limit: {:srid=>4326, :type=>"line_string"}
      t.index ["wkb_geometry"], name: "flight_routes_wkb_geometry_geom_idx", using: :gist
    end

    create_table "open_airports", primary_key: "ogc_fid", id: :serial, force: :cascade do |t|
      t.string "id"
      t.string "name"
      t.string "city"
      t.string "country"
      t.string "faa"
      t.string "icao"
      t.string "alt"
      t.string "tz_offset"
      t.string "dst"
      t.string "tz"
      t.geometry "wkb_geometry", limit: {:srid=>4326, :type=>"st_point"}
      t.index ["wkb_geometry"], name: "open_airports_wkb_geometry_geom_idx", using: :gist
    end

    create_table "vulcanoes", primary_key: "ogc_fid", id: :serial, force: :cascade do |t|
      t.string "id"
      t.string "number_"
      t.string "name_"
      t.string "location"
      t.float "lat"
      t.float "lon"
      t.integer "elev"
      t.string "type_"
      t.string "status"
      t.string "time_frame"
      t.geometry "wkb_geometry", limit: {:srid=>4326, :type=>"st_point"}
      t.index ["wkb_geometry"], name: "vulcanoes_wkb_geometry_geom_idx", using: :gist
    end

  end
end
