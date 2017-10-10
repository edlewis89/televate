class Metric < ApplicationRecord
  has_many :cell_metrics
  has_many :cells, through: :cell_metrics
  
end
