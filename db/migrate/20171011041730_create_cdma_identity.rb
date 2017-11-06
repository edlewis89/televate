class CreateCdmaIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :cdma_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mbasestationid
      t.integer :mlatitude
      t.integer :mlongitude
      t.integer :mnetworkid
      t.integer :msystemid
      t.boolean :mregistered
      t.integer :mtimestamp,:limit => 8
      
      t.timestamps
    end
  end
end
