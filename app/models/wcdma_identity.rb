class WcdmaIdentity < ApplicationRecord
  has_many :wcdma_identity_metics
  has_many :metrics, through: :wcdma_identity_metics
end
