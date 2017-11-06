class CreateLteSignalStrength < ActiveRecord::Migration[5.1]
  def change
    create_table :lte_signal_strengths do |t|
      t.integer :mcqi
      t.integer :mrsrp
      t.integer :mrsrqc
      t.integer :mrssnr
      t.integer :mrsrq
      t.integer :msignalstrength, :limit => 8
      t.integer :mtimingadvance, :limit => 8
    
      t.timestamps
    end
  end
end
