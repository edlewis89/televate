class CreateRawCellInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :raw_cell_infos do |t|
      t.text :raw_cell_info
      t.timestamps
    end
  end
end
