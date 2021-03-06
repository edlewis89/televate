
#report_type (can be "Standard Report" or "Event Report")
#drive_mode: (can be Test Drive or Automatic mode)
#event_type: if an Event Report, then this prop will have event type valuel
require 'json'

class String
  def is_json?
    begin
      !!JSON.parse(self)
    rescue
      false
    end
  end
end


module CellInfo
  class Dsl
    attr_accessor :device_id, :line1number, :cell_info_object, :cell_location_object, :cell_ping_object, :cell_netstate_object, :cell_report_object, :ingested_json_data, :ingested_location_data, :ingested_report_data,
    :ingested_ping_data, :ingested_netstate_data
    
    def initialize(cell_device_id="", cell_line1number="", cell_info_data={}.to_json, cell_location_data={}.to_json, cell_ping_data={}.to_json, cell_netstate_data={}.to_json, cell_report_data={}.to_json, cell_timestamp={}.to_json)      
     
      asj = ActiveSupport::JSON
      if cell_device_id && cell_device_id != ''       
        @device_id = cell_device_id
        @line1number = cell_line1number if cell_line1number && cell_line1number != '' 
        
        @ingested_json_data = cell_info_data if cell_info_data && !cell_info_data.empty? 
        @ingested_location_data = cell_location_data  if cell_location_data && !cell_location_data.empty? unless cell_location_data.is_a?(JSON)  
        @ingested_ping_data = cell_ping_data  if cell_ping_data && !cell_ping_data.empty? unless cell_ping_data.is_a?(JSON)  
        @ingested_netstate_data = cell_netstate_data  if cell_netstate_data && !cell_netstate_data.empty? unless cell_netstate_data.is_a?(JSON) 
        @ingested_report_data = cell_report_data  if cell_report_data && !cell_report_data.empty? unless cell_report_data.is_a?(JSON) 
        
        # @ingested_json_data = asj.decode(cell_info_data)  if cell_info_data && !cell_info_data.empty?  
        # @ingested_location_data = asj.decode(cell_location_data)  if cell_location_data && !cell_location_data.empty?     
        # @ingested_ping_data = asj.decode(cell_ping_data)  if cell_ping_data && !cell_ping_data.empty? 
        # @ingested_netstate_data = asj.decode(cell_netstate_data)  if cell_netstate_data && !cell_netstate_data.empty?
        # @ingested_report_data = asj.decode(cell_report_data)  if cell_report_data && !cell_report_data.empty?
          
        # @ingested_json_data = asj.decode(cell_info_data)  if cell_info_data && !cell_info_data.empty?  
        # @ingested_location_data = asj.decode(cell_location_data)  if cell_location_data && !cell_location_data.empty?     
        # @ingested_ping_data = asj.decode(cell_ping_data)  if cell_ping_data && !cell_ping_data.empty? 
        # @ingested_netstate_data = asj.decode(cell_netstate_data)  if cell_netstate_data && !cell_netstate_data.empty?
        # @ingested_report_data = asj.decode(cell_report_data)  if cell_report_data && !cell_report_data.empty?
        begin
                    
          Rails.logger.info "----------->Parsed success cell info #{@ingested_json_data.inspect}" if cell_ping_data && !cell_ping_data.empty?                   
          @cell_info_object = JSON.parse(@ingested_json_data, object_class: OpenStruct) if @ingested_json_data && !@ingested_json_data.empty?
          Rails.logger.info "----------->Parsed success location #{@ingested_location_data.inspect}" if cell_location_data && !cell_location_data.empty?            
          @cell_location_object = JSON.parse(@ingested_location_data, object_class: OpenStruct) if @ingested_location_data && !@ingested_location_data.empty?
          Rails.logger.info "----------->Parsed success ping #{@ingested_ping_data.inspect}" if cell_info_data && !cell_info_data.empty?
          @cell_ping_object = JSON.parse(@ingested_ping_data, object_class: OpenStruct) if @ingested_ping_data && !@ingested_ping_data.empty?
          Rails.logger.info "----------->Parsed success netstate info #{@ingested_netstate_data.inspect}" if cell_netstate_data && !cell_netstate_data.empty?                
          @cell_netstate_object = JSON.parse(@ingested_netstate_data, object_class: OpenStruct) if @ingested_netstate_data && !@ingested_netstate_data.empty?
          Rails.logger.info "----------->Parsed success report info #{@ingested_report_data.inspect}" if cell_report_data && !cell_report_data.empty?            
          @cell_report_object = JSON.parse(@ingested_report_data, object_class: OpenStruct) if @ingested_report_data && !@ingested_report_data.empty?
          
          # @cell_info_object = JSON.parse(@ingested_json_data.to_json, object_class: OpenStruct) if @ingested_json_data && !@ingested_json_data.empty?
          # @cell_location_object = JSON.parse(@ingested_location_data.to_json, object_class: OpenStruct) if @ingested_location_data && !@ingested_location_data.empty?
          # @cell_ping_object = JSON.parse(@ingested_ping_data.to_json, object_class: OpenStruct) if @ingested_ping_data && !@ingested_ping_data.empty?
          # @cell_netstate_object = JSON.parse(@ingested_netstate_data.to_json, object_class: OpenStruct) if @ingested_netstate_data && !@ingested_netstate_data.empty?
          # @cell_report_object = JSON.parse(@ingested_report_data.to_json, object_class: OpenStruct) if @ingested_report_data && !@ingested_report_data.empty?
#           
          # @cell_info_object = JSON.parse(asj.encode(@ingested_json_data), object_class: OpenStruct) if @ingested_json_data && !@ingested_json_data.empty?
          # @cell_location_object = JSON.parse(asj.encode(@ingested_location_data), object_class: OpenStruct) if @ingested_location_data && !@ingested_location_data.empty?
          # @cell_ping_object = JSON.parse(asj.encode(@ingested_ping_data), object_class: OpenStruct) if @ingested_ping_data && !@ingested_ping_data.empty?
          # @cell_netstate_object = JSON.parse(asj.encode(@ingested_netstate_data), object_class: OpenStruct) if @ingested_netstate_data && !@ingested_netstate_data.empty?
          # @cell_report_object = JSON.parse(asj.encode(@ingested_report_data), object_class: OpenStruct) if @ingested_report_data && !@ingested_report_data.empty?
#           
          #Rails.logger.info "----------->Parsed success ping #{@cell_ping_object.inspect}" if cell_ping_data && !cell_ping_data.empty?
          #Rails.logger.info "----------->Parsed success location #{@cell_location_object.inspect}" if cell_location_data && !cell_location_data.empty?
          ##Rails.logger.info "----------->Parsed success cell info #{@cell_info_object.inspect}" if cell_info_data && !cell_info_data.empty?
          #Rails.logger.info "----------->Parsed success netstate info #{@ingested_netstate_data.inspect}" if cell_netstate_data && !cell_netstate_data.empty?       
          #Rails.logger.info "----------->Parsed success report info #{@cell_report_object.inspect}" if cell_report_data && !cell_report_data.empty?       
        
          true
        rescue JSON::ParserError => e
          Rails.logger.error "JSON Parsing Error: #{e.message}"
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
   
  end 
end