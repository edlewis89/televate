class CreateLteIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :lte_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mci
      t.integer :mmcc
      t.integer :mmnc
      t.integer :mpci
      t.integer :mtac
      t.integer :mearfcn
      t.boolean :mregistered
      t.integer :mcqi
      t.integer :mrsrp
      t.integer :mrsrqc
      t.integer :mrssnr
      t.integer :mrsrq
      t.integer :msignalstrength, :limit => 8
      t.integer :mtimingadvance, :limit => 8      
      t.datetime :mtimestamp
     
      t.timestamps
    end
  end
end
