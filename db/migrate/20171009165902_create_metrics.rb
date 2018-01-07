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
      
      t.index [:metric_id, :location_id]
      t.index [:metric_id, :ping_id]
      t.index [:metric_id, :report_id]
      t.index [:metric_id, :network_state_id]
      t.index [:metric_id, :ingested_datum_id]
      t.index [:metric_id, :cell_identity_lte_id]
      t.index [:metric_id, :cell_identity_cdma_id]
      t.index [:metric_id, :cell_identity_gsm_id]
      t.index [:metric_id, :cell_identity_wcdma_id]
      t.index [:metric_id, :cell_info_id]
      
    end
  end
end
