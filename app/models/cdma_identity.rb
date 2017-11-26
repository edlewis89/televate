class CdmaIdentity < ApplicationRecord
  #has_many :metrics, as: :metricable
  has_many :cdma_identities_metrics, dependent: :destroy, :class_name => 'CdmaIdentitiesMetrics'
  has_many :metrics, through: :cdma_identities_metrics
        
  # include ActiveModel::Serializers::JSON
# 
  # attr_accessor :mcid, :mmcc, :mmnc, :mlac, :mpsc, :mregistered, :mtimestamp
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