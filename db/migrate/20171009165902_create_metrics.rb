class CreateMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :metrics do |t|
      
      t.belongs_to :cell_identity_lte, index: true
      t.belongs_to :cell_signal_strength_lte, index: true
      t.belongs_to :cell_identity_cdma, index: true
      t.belongs_to :cell_signal_strength_cdma, index: true
      t.belongs_to :cell_identity_wcdma, index: true
      t.belongs_to :cell_signal_strength_wcdma, index: true
      t.belongs_to :cell_identity_gsm, index: true
      t.belongs_to :cell_signal_strength_gsm, index: true
      t.belongs_to :cell_location, index: true
      t.belongs_to :ping, index: true
      t.belongs_to :cell_info, index: true
      t.belongs_to :raw_cell_info, index: true
      
      t.timestamps
    end
  end
end
