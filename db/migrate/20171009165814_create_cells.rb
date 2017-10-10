class CreateCells < ActiveRecord::Migration[5.1]
  def change
    create_table :cells do |t|
      t.integer :cell_device_id
      t.integer :cell_device_rev

      t.timestamps
    end
  end
end
