class CreateCdmaSignalStrength < ActiveRecord::Migration[5.1]
  def change
    create_table :cdma_signal_strengths do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :bit_error_rate
      t.integer :signal_strength
      t.timestamps
      
      
    end
  end
end
