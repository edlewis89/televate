class CdmaSignalStrength < ApplicationRecord
  has_many :cdma_signal_strengths_metrics, dependent: :destroy, :class_name => 'CdmaSignalStrengthsMetrics'
  has_many :metrics, through: :cdma_signal_strengths_metrics
  
  # include ActiveModel::Serializers::JSON
#  
  # attr_accessor :bit_error_rate, :signal_strength
# 
  # def attributes=(hash)
    # hash.each do |key, value|
      # send("#{key}=", value)
    # end
  # end
# 
  # def attributes
    # instance_values
  # end
end
