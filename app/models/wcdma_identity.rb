class WcdmaIdentity < ApplicationRecord
  #has_many :metrics, as: :metricable
  has_many :wcdma_identities_metrics,  dependent: :destroy, :class_name => 'MetricsWcdmaIdentities'
  has_many :metrics, through: :wcdma_identities_metrics
  
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
