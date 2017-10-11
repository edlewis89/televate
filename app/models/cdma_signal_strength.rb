class CdmaSignalStrength < ApplicationRecord
  has_many :cdma_signal_strength_metrics
  has_many :metrics, through: :cdma_signal_strength_metrics
end
