class GsmIdentity < ApplicationRecord
  has_many :gsm_identities_metrics, dependent: :destroy, :class_name => 'GsmIdentitiesMetrics'
  has_many :metrics, through: :gsm_identities_metrics

  # include ActiveModel::Serializers::JSON
# 
  # attr_accessor :mcid, :mmcc, :mmnc, :mlac, :mregistered, :mtimestamp
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