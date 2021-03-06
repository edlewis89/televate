class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.belongs_to :metric, foreign_key: true, index: { unique: true } 
      t.integer :maccuracy
      t.integer :maltitude
      t.integer :mdistance
      t.integer :mspeed
      t.decimal :mbearing, {:precision=>6, :scale=>2}
      t.decimal :mlongitude, {:precision=>15, :scale=>10}
      t.decimal :mlatitude, {:precision=>15, :scale=>10}

      t.timestamps
    end
  end
end
