class CreateJoinTableLteSignalStrengthMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :lte_signal_strengths, :metrics do |t|
      # t.index [:lte_signal_strength_id, :metric_id]
      # t.index [:metric_id, :lte_signal_strength_id]
    end
  end
end
