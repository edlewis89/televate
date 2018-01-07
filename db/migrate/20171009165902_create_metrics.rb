class CreateMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :metrics do |t|
      t.belongs_to :network_state
      t.belongs_to :location
      t.belongs_to :ping
      t.belongs_to :report 
      #t.references :metricable, polymorphic: true,  index: true
     
      t.datetime :ingest_timestamp
     
      
      t.belongs_to :cell_identity_lte
      #t.belongs_to :cell_signal_strength_lte, index: true
      t.belongs_to :cell_identity_cdma
      #t.belongs_to :cell_signal_strength_cdma, index: true
      t.belongs_to :cell_identity_wcdma
      #t.belongs_to :cell_signal_strength_wcdma, index: true
      t.belongs_to :cell_identity_gsm
      #t.belongs_to :cell_signal_strength_gsm, index: true     
      t.belongs_to :cell_info
      t.belongs_to :ingested_datum
      t.timestamps
      
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
end
