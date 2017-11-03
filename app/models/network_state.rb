class NetworkState < ApplicationRecord 
   has_many :metrics, dependent: :destroy
end
