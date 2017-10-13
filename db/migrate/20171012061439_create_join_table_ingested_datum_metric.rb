class CreateJoinTableIngestedDatumMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :ingested_data, :metrics do |t|
      # t.index [:ingested_datum_id, :metric_id]
      # t.index [:metric_id, :ingested_datum_id]
    end
  end
end
