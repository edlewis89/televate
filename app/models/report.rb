class Report < ApplicationRecord
  has_many :metrics, dependent: :destroy
end
