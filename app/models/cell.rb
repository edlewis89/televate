class Cell < ApplicationRecord
  has_many :cells_metrics, dependent: :destroy, :class_name => 'CellsMetrics'
  has_many :metrics, through: :cells_metrics
  
end
