class CreateCellIdentityGsms < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_identity_gsms do |t|
      t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mcid
      t.integer :mmcc
      t.integer :mmnc
      t.integer :mlac
      t.boolean :mregistered
      t.integer :mtimestamp
      t.timestamps
    end
  end
end
