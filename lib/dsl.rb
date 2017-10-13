
module CellInfo
  class Dsl
    attr_accessor :device_id, :cell_info_object, :cell_location_object, :cell_ping_object, :raw_data, :line1number
    
    def initialize(device_id='', cell_line1number='', cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_timestamp='')
           
      #@location = cell_location_data #unless cell_location_data.empty? || cell_location_data == ''
      #@cell_ping_data = cell_ping_data #unless cell_ping_data.empty? || cell_ping_data == ''
      #@timestamp = cell_timestamp #unless cell_timestamp.nil? || cell_timestamp == ''     
      
      if device_id && cell_info_data && cell_location_data #&& @timestamp
        @device_id = device_id #unless device_id.nil? || device_id == ''
        @line1number = cell_line1number #@raw_data = cell_info_data #unless cell_info_data.empty? || cell_info_data == ''
        @cell_ping_object = JSON.parse(cell_ping_data, object_class: OpenStruct) unless cell_ping_data.empty?
        @cell_info_object = JSON.parse(cell_info_data, object_class: OpenStruct) unless cell_info_data.empty?
        @cell_location_object = JSON.parse(cell_location_data, object_class: OpenStruct) unless cell_location_data.empty?
      end         
    end
    
    def cell_info_size
      @cell_info_object.size
    end
    
    # def cell_ping_size
      # @cell_ping_object.size
    # end
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
    # def cell_location(index)
      # @cell_location_object[index].send('mCellLocation')
    # end 
    def cell_location_object
      @cell_location_object
    end 
    def cell_ping_object
      @cell_ping_object
    end 
    def extract
      @cell_info_object.each do |cell_info|
        yield
      
      #puts cell_info.mRegistered
      #if cell_info.mCellIdentityLte
      #puts "Lte"
      #end
      #if cell_info.mCellIdentityGsm
      #  puts "Gsm"
      #end
      #if cell_info.mCellIdentityWcdma
      #  puts "Wcdma"
      #end
      #if cell_info.mCellIdentityCdma
      #  puts "Cdma"
        
      #end
      end
    end
    
  end 
end