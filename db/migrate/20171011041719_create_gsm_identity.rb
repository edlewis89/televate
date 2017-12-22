class CreateGsmIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :gsm_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mcid,  :limit => 8
      t.integer :mmcc,  :limit => 8
      t.integer :mmnc,  :limit => 8
      t.integer :mlac,  :limit => 8
      t.boolean :mregistered
      t.integer :mbiterrorrate, :limit => 8
      t.integer :msignalstrength, :limit => 8
      t.datetime :mtimestamp     
      t.timestamps
    end
  end
end
