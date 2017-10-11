
module CellInfo
  class Dsl
    attr_accessor :device_id, 
    :location, :cell_ping_data, 
    :cell_ping_object, :cell_info_object, 
    :cell_location_object, :cell_info_data
    
    def initialize(device_id='', cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_timestamp='')
      
      @device_id = device_id #unless device_id.nil? || device_id == ''
      @cell_info_data = cell_info_data #unless cell_info_data.empty? || cell_info_data == ''
      @location = cell_location_data #unless cell_location_data.empty? || cell_location_data == ''
      @cell_ping_data = cell_ping_data #unless cell_ping_data.empty? || cell_ping_data == ''
      @timestamp = cell_timestamp #unless cell_timestamp.nil? || cell_timestamp == ''
      
      if @device_id && @location && @cell_ping_data && @timestamp
        init_json_parsing
      end         
    end
    
    def init_json_parsing
      @cell_ping_object = JSON.parse(@cell_ping_data, object_class: OpenStruct) unless @cell_ping_data.empty?
      @cell_info_object = JSON.parse(@cell_info_data, object_class: OpenStruct) unless @cell_info_data.empty?
      @cell_location_object = JSON.parse(@location, object_class: OpenStruct) unless @location.empty?
    end
    
    def cell_info_size
      @cell_info_object.size
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
    def cell_info_data
      @cell_info_data
    end  
    def cell_location
      @cell_location_object
    end
  end 
end