class LteIdentity < ApplicationRecord
  has_many :lte_identity_metrics
  has_many :metrics, through: :lte_identity_metrics
end
