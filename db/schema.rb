# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180107195422) do

  create_table "cdma_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "mbasestationid"
    t.integer "mlatitude"
    t.integer "mlongitude"
    t.bigint "mnetworkid"
    t.bigint "msystemid"
    t.boolean "mregistered"
    t.bigint "mcdmadbm"
    t.bigint "mcdmaecio"
    t.bigint "mevdodbm"
    t.bigint "mevdoecio"
    t.bigint "mevdosnr"
    t.datetime "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cdma_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cdma_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "cells", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cell_device_rev"
    t.string "cell_device_id"
    t.string "line1number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cells_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cell_id", null: false
    t.bigint "metric_id", null: false
    t.index ["cell_id", "metric_id"], name: "index_cells_metrics_on_cell_id_and_metric_id"
    t.index ["metric_id", "cell_id"], name: "index_cells_metrics_on_metric_id_and_cell_id"
  end

  create_table "gsm_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "mcid"
    t.bigint "mmcc"
    t.bigint "mmnc"
    t.bigint "mlac"
    t.boolean "mregistered"
    t.bigint "mbiterrorrate"
    t.bigint "msignalstrength"
    t.datetime "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gsm_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "gsm_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "ingested_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingested_data_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "ingested_datum_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "maccuracy"
    t.integer "maltitude"
    t.integer "mdistance"
    t.integer "mspeed"
    t.decimal "mbearing", precision: 6, scale: 2
    t.decimal "mlongitude", precision: 15, scale: 10
    t.decimal "mlatitude", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mprovider"
    t.index ["metric_id"], name: "index_locations_on_metric_id", unique: true
  end

  create_table "lte_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "mci"
    t.bigint "mmcc"
    t.bigint "mmnc"
    t.bigint "mpci"
    t.bigint "mtac"
    t.bigint "mearfcn"
    t.boolean "mregistered"
    t.decimal "mcqi", precision: 15
    t.bigint "mrsrp"
    t.bigint "mrsrqc"
    t.decimal "mrssnr", precision: 15
    t.bigint "mrsrq"
    t.bigint "msignalstrength"
    t.decimal "mtimingadvance", precision: 15
    t.bigint "mtimestamptype"
    t.datetime "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lte_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "lte_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "network_state_id"
    t.bigint "location_id"
    t.bigint "ping_id"
    t.bigint "report_id"
    t.datetime "ingest_timestamp"
    t.bigint "cell_identity_lte_id"
    t.bigint "cell_identity_cdma_id"
    t.bigint "cell_identity_wcdma_id"
    t.bigint "cell_identity_gsm_id"
    t.bigint "cell_info_id"
    t.bigint "ingested_datum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cell_identity_cdma_id"], name: "index_metrics_on_cell_identity_cdma_id"
    t.index ["cell_identity_gsm_id"], name: "index_metrics_on_cell_identity_gsm_id"
    t.index ["cell_identity_lte_id"], name: "index_metrics_on_cell_identity_lte_id"
    t.index ["cell_identity_wcdma_id"], name: "index_metrics_on_cell_identity_wcdma_id"
    t.index ["cell_info_id"], name: "index_metrics_on_cell_info_id"
    t.index ["ingested_datum_id"], name: "index_metrics_on_ingested_datum_id"
    t.index ["location_id"], name: "index_metrics_on_location_id"
    t.index ["network_state_id"], name: "index_metrics_on_network_state_id"
    t.index ["ping_id"], name: "index_metrics_on_ping_id"
    t.index ["report_id"], name: "index_metrics_on_report_id"
  end

  create_table "metrics_wcdma_identities", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "wcdma_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "network_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "network_type"
    t.datetime "system_timestamp_millis"
    t.string "network_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.decimal "ping_avg", precision: 6, scale: 3
    t.decimal "ping_max", precision: 6, scale: 3
    t.decimal "ping_min", precision: 6, scale: 3
    t.decimal "ttl", precision: 5, scale: 2
    t.decimal "time", precision: 5, scale: 2
    t.string "host"
    t.string "net"
    t.string "ip"
    t.text "output"
    t.bigint "ping_start_timestamp"
    t.boolean "pinged"
    t.decimal "pkt_loss", precision: 6, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_pings_on_metric_id", unique: true
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "report_type"
    t.string "event_type"
    t.string "drive_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wcdma_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "mcid"
    t.bigint "mmcc"
    t.bigint "mmnc"
    t.bigint "mlac"
    t.bigint "mpsc"
    t.boolean "mregistered"
    t.bigint "mbiterrorrate"
    t.bigint "msignalstrength"
    t.datetime "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "locations", "metrics"
  add_foreign_key "pings", "metrics"
end
