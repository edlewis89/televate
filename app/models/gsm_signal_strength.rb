class GsmSignalStrength < ApplicationRecord
  has_many :gsm_signal_strength_metrics
  has_many :metrics, through: :gsm_signal_strength_metrics
end
