class IngestedDataMetrics < ApplicationRecord
  belongs_to :ingested_datum 
  belongs_to :metric
end
