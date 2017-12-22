class CreateCdmaIdentity < ActiveRecord::Migration[5.1]
  def change
    create_table :cdma_identities do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :mbasestationid, :limit => 8
      t.integer :mlatitude, {:precision=>15, :scale=>2}
      t.integer :mlongitude, {:precision=>15, :scale=>2}
      t.integer :mnetworkid,  :limit => 8
      t.integer :msystemid,  :limit => 8
      t.boolean :mregistered
      t.integer :mcdmadbm,  :limit => 8
      t.integer :mcdmaecio,  :limit => 8
      t.integer :mevdodbm,  :limit => 8
      t.integer :mevdoecio,  :limit => 8
      t.integer :mevdosnr,  :limit => 8
      
      t.datetime :mtimestamp      
      t.timestamps
    end
  end
end
