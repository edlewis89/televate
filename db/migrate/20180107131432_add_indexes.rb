class AddIndexes < ActiveRecord::Migration[5.1]
  def change
     add_index :metrics, :network_state
     add_index :metrics, :location
     add_index :metrics, :ping
     add_index :metrics, :report
     add_index :metrics, :cell_identity_lte
     add_index :metrics, :cell_identity_cdma
     add_index :metrics, :cell_identity_wcdma
     add_index :metrics, :cell_identity_gsm
     add_index :metrics, :cell_info
     add_index :metrics, :ingested_datum
  end
end
