class LteSignalStrength < ApplicationRecord
  has_many :lte_signal_strength_metrics
  has_many :metrics, through: :lte_signal_strength_metrics
end
