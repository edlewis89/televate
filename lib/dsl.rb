module CellInfo
  class Dsl
    attr_accessor :device_id, :location, :cell_ping_data, :cell_ping_object, :cell_info_object, :cell_location_object
    def initialize(device_id, cell_info_data, cell_location_data, cell_ping_data, cell_timestamp)
      @device_id = device_id
      @location = cell_location_data
      @cell_ping_data = cell_ping_data
      @timestamp = cell_timestamp
      @cell_ping_object = JSON.parse(cell_ping_data, object_class: OpenStruct)
      @cell_info_object = JSON.parse(cell_info_data, object_class: OpenStruct)
      @cell_location_object = JSON.parse(cell_location_data, object_class: OpenStruct)
    end
    def cell_info_size
      @cell_info_object.size
    end
    def cell_location_size
      @cell_location_object.size
    end
    def cell_ping_size
      @cell_ping_object.size
    end
    def lte_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityLte')
    end
    def gsm_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityGsm')
    end
    def wcdma_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityWcdma')
    end
    def cdma_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityCdma')
    end
    def gsm_signal_strength(index)
      @cell_info_object[index].send('mCellSignalStrengthGsm')
    end
    def wcdma_signal_strength(index)
      @cell_info_object[index].send('mCellSignalStrengthWcdma')
    end
    def lte_signal_strength(index)
      @cell_info_object[index].send('mCellSignalStrengthLte')
    end
    def cdma_signal_strength(index)
      @cell_info_object[index].send('mCellISignalStrengthCdma')
    end 
    def cell_location(index)
      @cell_location_object[index].send('mCellLocation')
    end 
    def cell_ping(index)
      @cell_ping_object[index].send('mPing')
    end 
    
    def extract
      c = nil
      c = Cell.new({:device_id => @device_id}) unless @device_id.nil?      
      if c && c.valid?              
        for i in 0..cell_info_size - 1 
          cell_ping = Ping.new(self.cell_ping(i).to_h)
          cell_location = CellLocation.new(self.cell_location(i).to_h)
          cell_identity_lte = CellIdentityLte.new(self.lte_cell_identity(i).to_h)
          cell_identity_gsm = CellIdentityGsm.new(self.gsm_cell_identity(i).to_h)
          cell_identity_wcdma = CellIdentityWcdma.new(self.wcdma_cell_identity(i).to_h)
          cell_identity_cdma = CellIdentityCdma.new(self.cdma_cell_identity(i).to_h)
          cell_sig_strength_lte = CellSignalStrengthLte.new(self.lte_signal_strength(i).to_h)
          cell_sig_strength_gsm = CellSignalStrengthGsm.new(self.gsm_signal_strength(i).to_h)
          cell_sig_strength_wcdma = CellSignalStrengthWcdma.new(self.wcdma_signal_strength(i).to_h)
          cell_sig_strength_cdma = CellSignalStrengthCdma.new(self.cdma_signal_strength(i).to_h)
          raw_cell_info = RawCellInfo.new(cell_info_data)
          m = Metric.new({:cell_identity_lte_id => cell_identity_lte.id, 
            :cell_identity_gsm_id => cell_identity_gsm.id,
            :cell_identity_wcdma_id => cell_identity_wcdma.id, 
            :cell_identity_cdma_id => cell_identity_cdma.id, 
            :cell_sig_strength_lte_id => cell_signal_strength_lte.id, 
            :cell_sig_strength_gsm_id => cell_signal_strength_gsm.id, 
            :cell_sig_strength_wcdma_id => cell_signal_strength_wcdma.id, 
            :cell_sig_strength_cdma_id => cell_signal_strength_cdma.id,
            :cell_ping_id => cell_ping.id, 
            :cell_location_id => cell_location.id,
            :raw_cell_info => raw_cell_info.id
            })
         
          c.metrics << m
          c.save!        
        end 
      else
        false        
      end
    end  
  end 
end