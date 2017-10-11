class CreateJoinTableCdmaSignalStrengthMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cdma_signal_strengths, :metrics do |t|
      # t.index [:cdma_signal_strength_id, :metric_id]
      # t.index [:metric_id, :cdma_signal_strength_id]
    end
  end
end
