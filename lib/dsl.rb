
module CellInfo
  class Dsl
    attr_accessor :device_id, :line1number, :cell_info_object, :cell_location_object, :cell_ping_object
    
    def initialize(cell_device_id="", cell_line1number="", cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_timestamp={})      
      if cell_device_id && cell_device_id != ''       
        @device_id = cell_device_id
        @line1number = cell_line1number if cell_line1number && cell_line1number != ''              
        @cell_info_object = JSON.parse(cell_info_data, object_class: OpenStruct) if cell_info_data && !cell_info_data.empty?
        @cell_location_object = JSON.parse(cell_location_data, object_class: OpenStruct) if cell_location_data && !cell_location_data.empty?
        @cell_ping_object = JSON.parse(cell_ping_data, object_class: OpenStruct) if cell_ping_data && !cell_ping_data.empty?
      end         
    end

    def lte_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityLte')
    end
    def lte_cell_registered(index)
      @cell_info_object[index].send('mRegistered')
    end    
    def gsm_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityGsm')
    end
    def gsm_cell_registered(index)
      @cell_info_object[index].send('mRegistered')
    end
    def wcdma_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityWcdma')
    end
    def wcdma_cell_registered(index)
      @cell_info_object[index].send('mRegistered')
    end
    def cdma_cell_identity(index)
      @cell_info_object[index].send('mCellIdentityCdma')
    end
    def cdma_cell_registered(index)
      @cell_info_object[index].send('mRegistered')
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
    def cell_location_object
      @cell_location_object
    end 
    def cell_ping_object
      @cell_ping_object
    end    
  end 
end