class GsmSignalStrengthsMetrics < ApplicationRecord
  belongs_to :gsm_signal_strength 
  belongs_to :metric
end
