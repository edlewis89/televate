class Ping < ApplicationRecord
  has_many :metrics, dependent: :destroy
end
