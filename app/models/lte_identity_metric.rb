class LteIdentityMetric < ApplicationRecord 
  belongs_to :lte_identity 
  belongs_to :metric
end
