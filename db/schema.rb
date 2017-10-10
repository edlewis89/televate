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

ActiveRecord::Schema.define(version: 20171009234855) do

  create_table "cell_identity_cdmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "mcid"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mlac"
    t.integer "mpsc"
    t.boolean "mregistered"
    t.integer "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_identity_cdmas_on_metric_id", unique: true
  end

  create_table "cell_identity_gsms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "mcid"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mlac"
    t.boolean "mregistered"
    t.integer "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_identity_gsms_on_metric_id", unique: true
  end

  create_table "cell_identity_ltes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "mci"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mpci"
    t.integer "mtac"
    t.boolean "mregistered"
    t.integer "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_identity_ltes_on_metric_id", unique: true
  end

  create_table "cell_identity_wcdmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "mcid"
    t.integer "mmcc"
    t.integer "mmnc"
    t.integer "mlac"
    t.integer "mpsc"
    t.boolean "mregistered"
    t.integer "mtimestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_identity_wcdmas_on_metric_id", unique: true
  end

  create_table "cell_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "maccuracy"
    t.integer "maltitude"
    t.integer "mdistance"
    t.integer "mspeed"
    t.decimal "mlongitude", precision: 10, scale: 6
    t.decimal "mlatitude", precision: 10, scale: 6
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_locations_on_metric_id", unique: true
  end

  create_table "cell_metrics", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cell_id"
    t.bigint "metric_id"
    t.datetime "last_pull"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cell_id"], name: "index_cell_metrics_on_cell_id", unique: true
    t.index ["metric_id"], name: "index_cell_metrics_on_metric_id", unique: true
  end

  create_table "cell_signal_strength_cdmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "bit_error_rate"
    t.integer "signal_strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_signal_strength_cdmas_on_metric_id", unique: true
  end

  create_table "cell_signal_strength_gsms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "bit_error_rate"
    t.integer "signal_strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_signal_strength_gsms_on_metric_id", unique: true
  end

  create_table "cell_signal_strength_ltes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "mcqi"
    t.integer "mrsrp"
    t.integer "mrsrqc"
    t.integer "mrssnr"
    t.integer "signal_strength"
    t.integer "timing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_signal_strength_ltes_on_metric_id", unique: true
  end

  create_table "cell_signal_strength_wcdmas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "bit_error_rate"
    t.integer "signal_strength"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_cell_signal_strength_wcdmas_on_metric_id", unique: true
  end

  create_table "cells", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "cell_device_id"
    t.integer "cell_device_rev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metrics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cell_identity_lte_id"
    t.bigint "cell_signal_strength_lte_id"
    t.bigint "cell_identity_cdma_id"
    t.bigint "cell_signal_strength_cdma_id"
    t.bigint "cell_identity_wcdma_id"
    t.bigint "cell_signal_strength_wcdma_id"
    t.bigint "cell_identity_gsm_id"
    t.bigint "cell_signal_strength_gsm_id"
    t.bigint "cell_location_id"
    t.bigint "ping_id"
    t.bigint "cell_info_id"
    t.bigint "raw_cell_info_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cell_identity_cdma_id"], name: "index_metrics_on_cell_identity_cdma_id"
    t.index ["cell_identity_gsm_id"], name: "index_metrics_on_cell_identity_gsm_id"
    t.index ["cell_identity_lte_id"], name: "index_metrics_on_cell_identity_lte_id"
    t.index ["cell_identity_wcdma_id"], name: "index_metrics_on_cell_identity_wcdma_id"
    t.index ["cell_info_id"], name: "index_metrics_on_cell_info_id"
    t.index ["cell_location_id"], name: "index_metrics_on_cell_location_id"
    t.index ["cell_signal_strength_cdma_id"], name: "index_metrics_on_cell_signal_strength_cdma_id"
    t.index ["cell_signal_strength_gsm_id"], name: "index_metrics_on_cell_signal_strength_gsm_id"
    t.index ["cell_signal_strength_lte_id"], name: "index_metrics_on_cell_signal_strength_lte_id"
    t.index ["cell_signal_strength_wcdma_id"], name: "index_metrics_on_cell_signal_strength_wcdma_id"
    t.index ["ping_id"], name: "index_metrics_on_ping_id"
    t.index ["raw_cell_info_id"], name: "index_metrics_on_raw_cell_info_id"
  end

  create_table "pings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "metric_id"
    t.integer "ping_avg"
    t.integer "ping_max"
    t.integer "ping_min"
    t.decimal "ping_percent_loss", precision: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["metric_id"], name: "index_pings_on_metric_id", unique: true
  end

  create_table "raw_cell_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "raw_cell_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cell_identity_cdmas", "metrics"
  add_foreign_key "cell_identity_gsms", "metrics"
  add_foreign_key "cell_identity_ltes", "metrics"
  add_foreign_key "cell_identity_wcdmas", "metrics"
  add_foreign_key "cell_locations", "metrics"
  add_foreign_key "cell_metrics", "cells"
  add_foreign_key "cell_metrics", "metrics"
  add_foreign_key "cell_signal_strength_cdmas", "metrics"
  add_foreign_key "cell_signal_strength_gsms", "metrics"
  add_foreign_key "cell_signal_strength_ltes", "metrics"
  add_foreign_key "cell_signal_strength_wcdmas", "metrics"
  add_foreign_key "pings", "metrics"
end
