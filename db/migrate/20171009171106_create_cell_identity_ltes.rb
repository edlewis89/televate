class CreateCellIdentityLtes < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_identity_ltes do |t|
      t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mci
      t.integer :mmcc
      t.integer :mmnc
      t.integer :mpci
      t.integer :mtac
      t.boolean :mregistered
      t.integer :mtimestamp

      t.timestamps
    end
  end
end
