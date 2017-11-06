class CreateGsmIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :gsm_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mcid
      t.integer :mmcc
      t.integer :mmnc
      t.integer :mlac
      t.boolean :mregistered
      t.integer :mtimestamp, :limit => 8
      t.timestamps
    end
  end
end
