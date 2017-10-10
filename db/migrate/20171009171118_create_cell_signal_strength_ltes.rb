class CreateCellSignalStrengthLtes < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_signal_strength_ltes do |t|
      t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mcqi
      t.integer :mrsrp
      t.integer :mrsrqc
      t.integer :mrssnr
      t.integer :signal_strength
      t.integer :timing
    
      t.timestamps
    end
  end
end
