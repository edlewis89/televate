class IngestedDatum < ApplicationRecord
  #serialize :data, JSON
  has_many :ingested_data_metrics, dependent: :destroy, :class_name => 'IngestedDataMetrics'
  has_many :metrics, through: :ingested_data_metrics
end
