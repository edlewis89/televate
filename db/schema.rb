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

ActiveRecord::Schema.define(version: 20171103012618) do

  create_table "cdma_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mbasestationid"
    t.integer "mlatitude"
    t.integer "mlongitude"
    t.integer "mnetworkid"
    t.integer "msystemid"
    t.boolean "mregistered"
    t.string "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cdma_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cdma_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "cdma_signal_strengths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mcdmadbm"
    t.integer "mcdmaecio"
    t.integer "mevdodbm"
    t.integer "mevdoecio"
    t.integer "mevdosnr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cdma_signal_strengths_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cdma_signal_strength_id", null: false
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
  end

  create_table "gsm_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mcid"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mlac"
    t.boolean "mregistered"
    t.string "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gsm_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "gsm_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "gsm_signal_strengths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mbiterrorrate"
    t.integer "msignalstrength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gsm_signal_strengths_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "gsm_signal_strength_id", null: false
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
    t.decimal "mbearing", precision: 15, scale: 13
    t.decimal "mlongitude", precision: 15, scale: 13
    t.decimal "mlatitude", precision: 15, scale: 13
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_locations_on_metric_id", unique: true
  end

  create_table "lte_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mci"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mpci"
    t.integer "mtac"
    t.boolean "mregistered"
    t.string "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lte_identities_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "lte_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "lte_signal_strengths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mcqi"
    t.integer "mrsrp"
    t.integer "mrsrqc"
    t.integer "mrssnr"
    t.integer "mrsrq"
    t.integer "msignalstrength"
    t.string "mtimingadvance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lte_signal_strengths_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "lte_signal_strength_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "location_id"
    t.bigint "ping_id"
    t.datetime "ingest_timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_metrics_on_location_id", unique: true
    t.index ["ping_id"], name: "index_metrics_on_ping_id", unique: true
  end

  create_table "metrics_wcdma_identities", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "wcdma_identity_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "metrics_wcdma_signal_strengths", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "wcdma_signal_strength_id", null: false
    t.bigint "metric_id", null: false
  end

  create_table "network_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "net"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "ping_avg"
    t.integer "ping_max"
    t.integer "ping_min"
    t.string "host"
    t.string "net"
    t.text "output"
    t.decimal "ping_percent_loss", precision: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_pings_on_metric_id", unique: true
  end

  create_table "wcdma_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mcid"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mlac"
    t.integer "mpsc"
    t.boolean "mregistered"
    t.string "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wcdma_signal_strengths", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "mbiterrorrate"
    t.integer "msignalstrength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "locations", "metrics"
  add_foreign_key "pings", "metrics"
end
