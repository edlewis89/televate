class CreateJoinTableCdmaIdentityMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :cdma_identities, :metrics do |t|
      # t.index [:cdma_identity_id, :metric_id]
      # t.index [:metric_id, :cdma_identity_id]
    end
  end
end
