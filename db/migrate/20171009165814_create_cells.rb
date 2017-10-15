class CreateCells < ActiveRecord::Migration[5.1]
  def change
    create_table :cells do |t|  
      t.string :cell_device_rev
      t.string :cell_device_id
      t.string :line1number

      t.timestamps
    end
  end
end
