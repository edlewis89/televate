class CellsMetrics < ApplicationRecord
  #attr_accessor :cell_id, :metric_id
  belongs_to :cell
  belongs_to :metric
end
