class CreateJoinTableLteIdentityMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :lte_identities, :metrics do |t|
      # t.index [:lte_identity_id, :metric_id]
      # t.index [:metric_id, :lte_identity_id]
    end
  end
end
