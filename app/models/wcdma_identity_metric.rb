class WcdmaIdentityMetric < ApplicationRecord
  belongs_to :wcdma_identity 
  belongs_to :metric
end
