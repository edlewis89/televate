class GsmIdentitiesMetrics < ApplicationRecord
  belongs_to :gsm_identity 
  belongs_to :metric
end
