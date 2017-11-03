
module CellInfo
  class Dsl
    attr_accessor :device_id, :line1number, :cell_info_object, :cell_location_object, :cell_ping_object, :cell_netstate_object, :ingested_json_data, :ingested_location_data, :ingested_ping_data, :ingested_netstate_data
    
    def initialize(cell_device_id="", cell_line1number="", cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_netstate_data={}, cell_timestamp={})      
      if cell_device_id && cell_device_id != ''       
        @device_id = cell_device_id
        @line1number = cell_line1number if cell_line1number && cell_line1number != ''   
        @ingested_json_data = cell_info_data  if cell_info_data && !cell_info_data.empty?  
        @ingested_location_data = cell_location_data  if cell_location_data && !cell_location_data.empty?     
        @ingested_ping_data = cell_ping_data  if cell_ping_data && !cell_ping_data.empty? 
        @ingested_netstate_data = cell_netstate_data  if cell_netstate_data && !cell_netstate_data.empty?
        puts "----------->Parsed success ping #{@cell_ping_object.inspect}" if cell_ping_data && !cell_ping_data.empty?
        puts "----------->Parsed success location #{@cell_location_object.inspect}" if cell_location_data && !cell_location_data.empty?
        puts "----------->Parsed success cell info #{@cell_info_object.inspect}" if cell_info_data && !cell_info_data.empty?
        puts "----------->Parsed success netstate info #{@ingested_netstate_data.inspect}" if cell_netstate_data && !cell_netstate_data.empty?       
        begin
          @cell_info_object = JSON.parse(@ingested_json_data, object_class: OpenStruct) if @ingested_json_data && !@ingested_json_data.empty?
          @cell_location_object = JSON.parse(@ingested_location_data, object_class: OpenStruct) if @ingested_location_data && !@ingested_location_data.empty?
          @cell_ping_object = JSON.parse(@ingested_ping_data, object_class: OpenStruct) if @ingested_ping_data && !@ingested_ping_data.empty?
          @cell_netstate_object = JSON.parse(@ingested_netstate_data, object_class: OpenStruct) if @ingested_netstate_data && !@ingested_netstate_data.empty?
          
          true
        rescue JSON::ParserError => e
          puts "Error parsing #{e}"
          false
        end
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