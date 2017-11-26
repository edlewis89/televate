class LteIdentity < ApplicationRecord
  #has_many :metrics, as: :metricable
  has_many :lte_identities_metrics, dependent: :destroy, :class_name => 'LteIdentitiesMetrics'
  has_many :metrics, through: :lte_identities_metrics
  
  #include ActiveModel::Serializers::JSON

  #attr_accessor :mci, :mmcc, :mmnc, :mpci, :mtac, :mregistered, :mtimestamp

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
