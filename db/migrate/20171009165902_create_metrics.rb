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
     
       
      
    end
  end
end
