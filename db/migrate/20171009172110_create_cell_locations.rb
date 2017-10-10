class CreateCellLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_locations do |t|
      t.belongs_to :metric, index: { unique: true }, foreign_key: true
      t.integer :maccuracy
      t.integer :maltitude
      t.integer :mdistance
      t.integer :mspeed
      t.decimal :mlongitude, {:precision=>10, :scale=>6}
      t.decimal :mlatitude, {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end
