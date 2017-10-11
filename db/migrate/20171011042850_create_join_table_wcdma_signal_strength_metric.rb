class CreateJoinTableWcdmaSignalStrengthMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :wcdma_signal_strengths, :metrics do |t|
      # t.index [:wcdma_signal_strength_id, :metric_id]
      # t.index [:metric_id, :wcdma_signal_strength_id]
    end
  end
end
