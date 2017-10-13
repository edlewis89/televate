class CreateJoinTableWcdmaIdentityMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :wcdma_identities, :metrics do |t|
      # t.index [:wcdma_identity_id, :metric_id]
      # t.index [:metric_id, :wcdma_identity_id]
    end
  end
end
