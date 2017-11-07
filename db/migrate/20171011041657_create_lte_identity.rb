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
      t.integer :mtimestamp, :limit => 8
      
      t.timestamps
    end
  end
end
