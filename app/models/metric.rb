class Metric < ApplicationRecord
  belongs_to :ping
  belongs_to :location
  
  
  has_many :cells_metrics, dependent: :destroy, :class_name => 'CellsMetrics'
  has_many :cells, through: :cells_metrics
  accepts_nested_attributes_for :cells_metrics, :cells
  
  has_many :ingested_data_metrics, dependent: :destroy, :class_name => 'IngestedDataMetrics'
  has_many :ingested_datum, through: :ingested_data_metrics
  
  has_many :wcdma_signal_strengths_metrics, dependent: :destroy, :class_name => 'MetricsWcdmaSignalStrengths'
  has_many :wcdma_signal_strengths, through: :wcdma_signal_strengths_metrics
  
  has_many :gsm_signal_strengths_metrics, dependent: :destroy, :class_name => 'GsmSignalStrengthsMetrics'
  has_many :gsm_signal_strengths, through: :gsm_signal_strengths_metrics
  
  has_many :lte_signal_strengths_metrics, dependent: :destroy, :class_name => 'LteSignalStrengthsMetrics'
  has_many :lte_signal_strengths, through: :lte_signal_strengths_metrics
  
  has_many :cdma_signal_strengths_metrics, dependent: :destroy, :class_name => 'CdmaSignalStrengthsMetrics'
  has_many :cdma_signal_strengths, through: :cdma_signal_strengths_metrics
  
  has_many :cdma_identities_metrics, dependent: :destroy, :class_name => 'CdmaIdentitiesMetrics'
  has_many :cdma_identities, through: :cdma_identities_metrics
  
  has_many :wcdma_identities_metrics, dependent: :destroy, :class_name => 'MetricsWcdmaIdentities'
  has_many :wcdma_identities, through: :wcdma_identities_metrics
  
  has_many :gsm_identities_metrics, dependent: :destroy, :class_name => 'GsmIdentitiesMetrics'
  has_many :gsm_identities, through: :gsm_identities_metrics
  
  has_many :lte_identities_metrics, dependent: :destroy, :class_name => 'LteIdentitiesMetrics'
  has_many :lte_identities, through: :lte_identities_metrics
  
end
