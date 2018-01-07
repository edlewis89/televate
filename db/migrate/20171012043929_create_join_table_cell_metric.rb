class CreateJoinTableCellMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cells, :metrics do |t|
      t.index [:cell_id, :metric_id]
      t.index [:metric_id, :cell_id]
      
      #t.belongs_to :cell, index: { unique: true }, foreign_key: true
      #t.belongs_to :metric, index: { unique: true }, foreign_key: true   
      #t.datetime :last_ingest
    end
  end
end
