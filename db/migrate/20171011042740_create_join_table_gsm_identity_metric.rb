class CreateJoinTableGsmIdentityMetric < ActiveRecord::Migration[5.1]
  def change
    create_join_table :gsm_identities, :metrics do |t|
      # t.index [:gsm_identity_id, :metric_id]
      # t.index [:metric_id, :gsm_identity_id]
    end
  end
end
