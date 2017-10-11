class GsmIdentityMetric < ApplicationRecord
  belongs_to :gsm_identity 
  belongs_to :metric
end
