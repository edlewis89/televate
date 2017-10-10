class CreateCellMetrics < ActiveRecord::Migration[5.1]
  def change
    create_table :cell_metrics, id: false do |t|
      t.belongs_to :cell, index: { unique: true }, foreign_key: true
      t.belongs_to :metric, index: { unique: true }, foreign_key: true   
      t.datetime :last_pull

      t.timestamps
    end
  end
end
