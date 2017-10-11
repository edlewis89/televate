class GsmIdentity < ApplicationRecord
  has_many :gsm_identity_metrics
  has_many :metrics, through: :gsm_identity_metrics
end