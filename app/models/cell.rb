class Cell < ApplicationRecord
  has_many :cell_metrics
  has_many :metrics, through: :cell_metrics
  
end
