class CdmaIdentityMetric < ApplicationRecord
  belongs_to :cdma_identity 
  belongs_to :metric
end
