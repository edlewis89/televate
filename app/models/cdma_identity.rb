class CdmaIdentity < ApplicationRecord
  has_many :cdma_identity_metrics
  has_many :metrics, through: :cdma_identity_metrics
end