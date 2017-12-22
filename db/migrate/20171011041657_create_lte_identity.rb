class CreateLteIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :lte_identities do |t|
      
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mci,  :limit => 8
      t.integer :mmcc,  :limit => 8
      t.integer :mmnc,  :limit => 8
      t.integer :mpci,  :limit => 8
      t.integer :mtac,  :limit => 8
      t.integer :mearfcn,  :limit => 8
      t.boolean :mregistered
      t.decimal :mcqi,  {:precision=>15, :scale=>0}
      t.integer :mrsrp,  :limit => 8
      t.integer :mrsrqc,  :limit => 8
      t.decimal :mrssnr,  {:precision=>15, :scale=>0}
      t.integer :mrsrq,  :limit => 8
      t.integer :msignalstrength, :limit => 8
      t.decimal :mtimingadvance, {:precision=>15, :scale=>0}  
      t.integer :mtimestamptype, :limit => 8    
      t.datetime :mtimestamp
     
     
      t.timestamps
    end
  end
end
