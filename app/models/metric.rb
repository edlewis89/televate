class Metric < ApplicationRecord
  has_many :cell_metrics
  has_many :cells, through: :cell_metrics
  
  has_many :wcdma_signal_strength_metrics
  has_many :wcdma_signal_strengths, through: :wcdma_signal_strength_metrics
  
  has_many :gsm_signal_strength_metrics
  has_many :gsm_signal_strengths, through: :gsm_signal_strength_metrics
  
  has_many :lte_signal_strength_metrics
  has_many :lte_signal_strengths, through: :lte_signal_strength_metrics
  
  has_many :cdma_signal_strength_metrics
  has_many :cdma_signal_strengths, through: :cdma_signal_strength_metrics
  
  has_many :cdma_identity_metrics
  has_many :cdma_identities, through: :cdma_identity_metrics
  
  has_many :wcdma_identity_metrics
  has_many :wcdma_identities, through: :wcdma_identity_metrics
  
  has_many :gsm_identity_metrics
  has_many :gsm_identities, through: :gsm_identity_metrics
  
  has_many :lte_identity_metrics
  has_many :lte_identities, through: :lte_identity_metrics
  
end
