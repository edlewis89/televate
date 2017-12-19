require 'dsl'
require 'ping_parser.rb'

class API::V1::UploadController < ApplicationController
  #before_action :set_page, :only => [:report]
  CELLS_PER_PAGE = 5
  # GET /cell_info
  def index
    @result = {}
    c = Cell.order("updated_at").last    
    if c
      c.metrics.each do |cm|
        cm.ingested_data_metrics.each_with_index do |m, indx|
          @result[indx] = {:raw => m.ingested_datum}
        end
      end
    else
      @result[0] = {:message => "no data ingested"}    
    end    
    json_response(@result)
  end
  
  def report
    @cells = Cell.paginate(:page => set_page, :per_page => CELLS_PER_PAGE).order("created_at ASC") 
  end

  # POST /create
  def create
    #puts "Creating cell info ..."
    # columns 1: device_id
    # column 2: line1number
    # columns 3: cellInfo
    # columns 4: location
    # columns 5: network_state  
    # columns 6: timestamp
    
    if cell_info_params
      
      conditions = {}
      conditions[:device_id] = params[:device_id] 
      conditions[:line1number] = params[:line1number] 
      conditions[:cellinfo] = params[:cellinfo] 
      conditions[:location] = params[:location]   
      conditions[:ping] = params[:ping] 
      conditions[:network_state] = params[:network_state] 
      conditions[:report] = params[:report_type] 
      conditions[:timestamp] = params[:timestamp] 
     
      #cell_device_id="", cell_line1number="", cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_timestamp={}       
      dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:line1number], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:network_state], conditions[:report], conditions[:timestamp])      
      if dsl 
        if extract(dsl)                 
          success_upload(conditions)
        else
          ingest_error
        end   
      else
        ingest_error
      end
        
    else
      ingest_error     
    end    
  end
  

  # GET /cell/:id
  #def show
  #  set_cell_info
  #  json_response(@cell)
  #end

  # PUT /cell/:id
  # def update
    # set_cell_info
    # @cell.update(cell_info_params)
    # head :no_content
  # end

  # DELETE /cell/:id
  # def destroy
    # set_cell_info
    # @cell.destroy
    # head :no_content
  # end

  private
  
  def extract(dsl)
    begin
      if dsl.device_id && dsl.device_id != ''
        cell = Cell.where(:cell_device_id => dsl.device_id).first
        if cell
          #update
          return update_cell_info(dsl, cell)
          
        else
          return insert_cell_info(dsl)
        end
      else
       return false                    
      end #if device_id
    rescue StandardError => e
      puts "Error: #{e}"
      return false
    end
  end
  
  
  
  def update_cell_info(dsl, c)
    
    ####################################################
    #  UPDATE
    #
    ####################################################  
    c.with_lock do
      if !dsl.cell_info_object.nil? && !dsl.cell_info_object.empty?    
          puts "...Updating Cell Object #{c.cell_device_id}"
          ####################################################
          #  METRIC
          #
          ####################################################   
          m = Metric.new({:ingest_timestamp => DateTime.now()})         
          puts "...Initialized Metric Object #{m.ingest_timestamp}"
          
          m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.ingested_json_data}) if dsl.ingested_json_data
          m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.ingested_location_data}) if dsl.ingested_location_data
          m.ingested_datum << IngestedDatum.new({:name => 'cell_ping', :data => dsl.ingested_ping_data}) if dsl.ingested_ping_data
          m.ingested_datum << IngestedDatum.new({:name => 'cell_report', :data => dsl.ingested_report_data}) if dsl.ingested_report_data
          m.ingested_datum << IngestedDatum.new({:name => 'cell_netstate', :data => dsl.ingested_netstate_data}) if dsl.ingested_netstate_data
          puts "...added raw data #{m.ingested_datum.size}"
          
          ####################################################
          #  PING
          #
          ####################################################         
          if !dsl.cell_ping_object.nil?
            ping = Ping.new()
            ingest_ping_hash ={}
            ping_hash = {}          
            ping_hash = dsl.cell_ping_object.each_pair.map{|k, v| [k.downcase, v]}.to_h if !dsl.cell_ping_object.nil?
            #puts "################ #{ping_hash.inspect }" 
            #puts ".......... ping output #{ping_hash[:output]}"            
            output = ping_hash[:output] 
            if output   
              pp = PingParser.new(output)  
                 
              if pp       
                ingest_ping_hash=ping_hash.merge(pp.to_h)                                     
                puts "...ingest_ping_hash parse #{ingest_ping_hash}"             
                ping.update_attributes(ingest_ping_hash)
                m.ping_id = ping.id                                                                       
              end  
            end
            #puts ingest_ping_hash
            #m.create_ping(ingest_ping_hash)
          end
          ####################################################
          #  LOCATION
          #
          #################################################### 
          if dsl.cell_location_object && !dsl.cell_location_object.empty?
            puts "...adding location data #{dsl.cell_location_object}" unless dsl.cell_location_object.nil?
            location = Location.new()
            ingest_location_hash ={}
            location_hash={}
            
            location_hash = dsl.cell_location_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
            puts "...location parse #{location_hash}" 
            ingest_location_hash = location_hash.select{|k, v| ingest_location_hash[k.downcase]=v if location.respond_to?k.downcase.to_s} 
            puts "...ingest_location_hash parse #{ingest_location_hash}" 
            location.update_attributes(ingest_location_hash)
            m.location_id = location.id
            
          end
          
          ####################################################
          #  Net State
          #
          #################################################### 
          if dsl.cell_netstate_object && !dsl.cell_netstate_object.empty?
            puts "...adding netstate data #{dsl.cell_netstate_object}" unless dsl.cell_netstate_object.nil?
            netState = NetworkState.new()
            ingest_netstate_hash ={}
            netstate_hash={}
            
            netstate_hash = dsl.cell_netstate_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
            puts "...net state parse #{netstate_hash}" 
            ingest_netstate_hash = netstate_hash.select{|k, v| ingest_netstate_hash[k.downcase]=v if netState.respond_to?k.downcase.to_s} 
            puts "...ingest_netstate_hash parse #{ingest_netstate_hash}" 
            
            ingest_netstate_hash.each do |key, value|
              if key.to_s == "system_timestamp_millis"
                system_time = value.to_i/1000
                system_timestamp = DateTime.strptime(system_time.to_s, '%s')
                netState.update_attribute(:system_timestamp_millis, system_timestamp)
              else
                netState.update_attributes(ingest_netstate_hash)
              end               
            end              
            
            
            m.network_state_id = netState.id
            
          end
          
          ####################################################
          #  REPORT
          #
          ####################################################         
          if !dsl.cell_report_object.nil?
            report = Report.new()
            ingest_report_hash ={}
            report_hash = dsl.cell_report_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
            puts "...report parse #{report_hash}" 
            ingest_report_hash = report_hash.select{|k, v| ingest_report_hash[k.downcase]=v if report.respond_to?k.downcase.to_s} 
            puts "...ingest_report_hash parse #{ingest_report_hash}" 
            report.update_attributes(ingest_report_hash)
            m.report_id = report.id                                           
             
          end
          
          ####################################################
          #  CELL INFO
          #
          #################################################### 
          #only collect 6 mregistered= false
          mr_counter = 0
          dsl.cell_info_object.each do |cell_info|            
          
            ####################################################
            #  LTE IDENTITY
            #  
            #################################################### 
            
            if cell_info.mCellIdentityLte && !cell_info.mCellIdentityLte.empty?
              lte_identity = LteIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
              ingest_lte_identity_hash ={}            
              ingest_lte_identity_hash = cell_info.mCellIdentityLte.each_pair.map{|k,v| [k.downcase, v] if lte_identity.respond_to?k.downcase.to_s}.to_h       
              lte_identity.update_attributes(ingest_lte_identity_hash) 
              
            
              if cell_info.mCellSignalStrengthLte
                #lte_sig_strength = LteSignalStrength.new({}) 
                lte_sig_strength_hash ={}            
                lte_sig_strength_hash = cell_info.mCellSignalStrengthLte.each_pair.map{|k,v| [k.downcase, v] if lte_identity.respond_to?k.downcase.to_s}.to_h           
                lte_identity.update_attributes(lte_sig_strength_hash) 
                #m.lte_signal_strengths << lte_identity 
              end
              m.lte_identities << lte_identity 
            end
            
            
            ####################################################
            #  GSM IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityGsm
              gsm_identity = GsmIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
              ingest_gsm_identity_hash ={}            
              ingest_gsm_identity_hash = cell_info.mCellIdentityGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_identity.respond_to?k.downcase.to_s}.to_h           
              gsm_identity.update_attributes(ingest_gsm_identity_hash)               
              if cell_info.mCellSignalStrengthGsm
                #gsm_sig_strength = GsmSignalStrength.new({}) 
                gsm_sig_strength_hash ={}            
                gsm_sig_strength_hash = cell_info.mCellSignalStrengthGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_identity.respond_to?k.downcase.to_s}.to_h           
                gsm_identity.update_attributes(gsm_sig_strength_hash) 
                #m.gsm_signal_strengths << gsm_sig_strength 
              end
              m.gsm_identities << gsm_identity 
            end
            
            
            ####################################################
            #  WCDMA IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityWcdma
              wcdma_identity = WcdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
              ingest_wcdma_identity_hash ={}            
              ingest_wcdma_identity_hash = cell_info.mCellIdentityWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_identity.respond_to?k.downcase.to_s}.to_h           
              wcdma_identity.update_attributes(ingest_wcdma_identity_hash)               
              if cell_info.mCellSignalStrengthWcdma
                #wcdma_sig_strength = WcdmaSignalStrength.new({}) 
                wcdma_sig_strength_hash ={}            
                wcdma_sig_strength_hash = cell_info.mCellSignalStrengthWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_identity.respond_to?k.downcase.to_s}.to_h           
                wcdma_identity.update_attributes(wcdma_sig_strength_hash) 
                #m.wcdma_signal_strengths << wcdma_sig_strength 
              end
              m.wcdma_identities << wcdma_identity 
            end
            
            ####################################################
            #  CDMA IDENTITY
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellIdentityCdma
              cdma_identity = CdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
              ingest_cdma_identity_hash ={}            
              ingest_cdma_identity_hash = cell_info.mCellIdentityCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_identity.respond_to?k.downcase.to_s}.to_h           
              cdma_identity.update_attributes(ingest_cdma_identity_hash)                
              if cell_info.mCellSignalStrengthCdma
                #cdma_sig_strength = CdmaSignalStrength.new({}) 
                cdma_sig_strength_hash ={}            
                cdma_sig_strength_hash = cell_info.mCellSignalStrengthCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_identity.respond_to?k.downcase.to_s}.to_h           
                cdma_identity.update_attributes(cdma_sig_strength_hash) 
                #m.cdma_signal_strengths << cdma_sig_strength 
              end 
              m.cdma_identities << cdma_identity   
            end
            
            ####################################################
            #  LTE Signal Strength 
            #  
            ####################################################
            #puts cell_info.mCellSignalStrengthLte
           
            
            ####################################################
            #  GSM Signal Strength 
            #  
            ####################################################
            #puts cell_info.mCellSignalStrengthGsm
           
            
            ####################################################
            #  WCDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            
            
            ####################################################
            #  CDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            
          end #for loop
          m.save
          c.metrics<<m
          c.save
        else
          puts "no cell info object to update"
          return true
       end
    end # with_lock
  end
  
  def insert_cell_info(dsl)
    ####################################################
    #  CELL
    #
    ####################################################  
        c = Cell.new({:cell_device_id => dsl.device_id})
        c.with_lock do
          if c.valid? && dsl.cell_info_object && !dsl.cell_info_object.empty?
            c.line1number = dsl.line1number if dsl.line1number
            puts "...Initialized Cell Object #{c.cell_device_id}"
            ####################################################
            #  METRIC
            #
            ####################################################   
            m = Metric.new({:ingest_timestamp => DateTime.now()})
           
            puts "...Initialized Metric Object #{m.ingest_timestamp}"
            
            m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.ingested_json_data}) if dsl.ingested_json_data
            m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.ingested_location_data}) if dsl.ingested_location_data
            m.ingested_datum << IngestedDatum.new({:name => 'cell_ping', :data => dsl.ingested_ping_data}) if dsl.ingested_ping_data
            m.ingested_datum << IngestedDatum.new({:name => 'cell_report', :data => dsl.ingested_report_data}) if dsl.ingested_report_data
            m.ingested_datum << IngestedDatum.new({:name => 'cell_netstate', :data => dsl.ingested_netstate_data}) if dsl.ingested_netstate_data 
            puts "...added raw data #{m.ingested_datum.size}"
            
            ####################################################
            #  PING
            #
            ####################################################         
            if !dsl.cell_ping_object.nil?
              ping = Ping.new()                           
              ingest_ping_hash ={}
              ping_hash = {}                           
              ping_hash = dsl.cell_ping_object.each_pair.map{|k, v| [k.downcase, v]}.to_h if !dsl.cell_ping_object.nil?
              #puts "################ #{ping_hash[:output].inspect }" 
              output = ping_hash[:output] 
              if output   
                pp = PingParser.new(output)  
               
                if pp       
                  ingest_ping_hash=ping_hash.merge(pp.to_h)                                           
                  puts "...ingest_ping_hash parse #{ingest_ping_hash}"                  
                  ping.update_attributes(ingest_ping_hash)
                  m.ping_id = ping.id                                                                         
                end  
              end                            
            end
            ####################################################
            #  LOCATION
            #
            #################################################### 
            if dsl.cell_location_object && !dsl.cell_location_object.empty?
              puts "...adding location data #{dsl.cell_location_object}" 
              location = Location.new()
              ingest_location_hash ={}
              location_hash={}
              location_hash = dsl.cell_location_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
              puts "...location parse #{location_hash}" 
              ingest_location_hash = location_hash.select{|k, v| ingest_location_hash[k.downcase]=v if location.respond_to?k.downcase.to_s}  
              puts "...ingest_location_hash parse #{ingest_location_hash}" 
              location.update_attributes(ingest_location_hash)
              m.location_id = location.id
              puts "...ingest location data"
            end
            
            ####################################################
            #  Net State
            #
            #################################################### 
            if dsl.cell_netstate_object && !dsl.cell_netstate_object.empty?
              puts "...adding netstate data #{dsl.cell_netstate_object}" unless dsl.cell_netstate_object.nil?
              netState = NetworkState.new()
              ingest_netstate_hash ={}
              netstate_hash={}
              
              netstate_hash = dsl.cell_netstate_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
              puts "...net state parse #{netstate_hash}" 
              ingest_netstate_hash = netstate_hash.select{|k, v| ingest_netstate_hash[k.downcase]=v if netState.respond_to?k.downcase.to_s} 
              puts "...ingest_netstate_hash parse #{ingest_netstate_hash}" 
              ingest_netstate_hash.each do |key, value|
                if key.to_s == "system_timestamp_millis"
                  system_time = value.to_i/1000
                  system_timestamp = DateTime.strptime(system_time.to_s, '%s')
                  netState.update_attribute(:system_timestamp_millis, system_timestamp)
                else
                  netState.update_attributes(ingest_netstate_hash)
                end               
              end              
              m.network_state_id = netState.id
              
            end
            
            ####################################################
            #  REPORT
            #
            ####################################################         
            if !dsl.cell_report_object.nil?
              report = Report.new()
              ingest_report_hash ={}
              report_hash = dsl.cell_report_object.each_pair.map{|k, v| [k.downcase, v]}.to_h 
              puts "...report parse #{report_hash}" 
              ingest_report_hash = report_hash.select{|k, v| ingest_report_hash[k.downcase]=v if report.respond_to?k.downcase.to_s} 
              puts "...ingest_report_hash parse #{ingest_report_hash}" 
              report.update_attributes(ingest_report_hash)
              m.report_id = report.id                                           
               
            end
            
            
            ####################################################
            #  CELL INFO
            #
            #################################################### 
            
            dsl.cell_info_object.each do |cell_info|            
            
              ####################################################
              #  LTE IDENTITY
              #  
              #################################################### 
              if cell_info.mCellIdentityLte && !cell_info.mCellIdentityLte.empty?            
                lte_identity = LteIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
                ingest_lte_identity_hash ={}            
                ingest_lte_identity_hash = cell_info.mCellIdentityLte.each_pair.map{|k,v| [k.downcase, v] if lte_identity.respond_to?k.downcase.to_s}.to_h       
                lte_identity.update_attributes(ingest_lte_identity_hash) 
                puts "...adding CellIdentityLte data #{ingest_lte_identity_hash}" 
                 
                if cell_info.mCellSignalStrengthLte && !cell_info.mCellSignalStrengthLte.empty?
                  #lte_sig_strength = LteSignalStrength.new({}) 
                  lte_sig_strength_hash ={}            
                  lte_sig_strength_hash = cell_info.mCellSignalStrengthLte.each_pair.map{|k,v| [k.downcase, v] if lte_identity.respond_to?k.downcase.to_s}.to_h           
                  lte_sig_strength_hash.each do |key, value|
                    if key.to_s == "mtimestamp"
                      mtimestamp = DateTime.strptime(value.to_s, '%s')
                      lte_identity.update_attribute(:mtimestamp, mtimestamp)
                    else
                      lte_identity.update_attributes(lte_sig_strength_hash)
                    end               
                  end           
                  
                  
                  #lte_identity.update_attributes(lte_sig_strength_hash) 
                  #m.lte_identity << lte_sig_strength 
                end
                m.lte_identities << lte_identity
              end
              
              ####################################################
              #  GSM IDENTITY
              #  
              ####################################################
              puts cell_info.inspect
              if cell_info.mCellIdentityGsm && !cell_info.mCellIdentityGsm.empty?              
                gsm_identity = GsmIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
                ingest_gsm_identity_hash ={}                        
                ingest_gsm_identity_hash = cell_info.mCellIdentityGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_identity.respond_to?k.downcase.to_s}.to_h           
                gsm_identity.update_attributes(ingest_gsm_identity_hash) 
                puts "...adding CellIdentityGsm data #{ingest_gsm_identity_hash}"
                
                if cell_info.mCellSignalStrengthGsm && !cell_info.mCellSignalStrengthGsm.empty?
                  #gsm_sig_strength = GsmSignalStrength.new({}) 
                  gsm_sig_strength_hash ={}            
                  gsm_sig_strength_hash = cell_info.mCellSignalStrengthGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_identity.respond_to?k.downcase.to_s}.to_h           
                  #gsm_identity.update_attributes(gsm_sig_strength_hash) 
                  gsm_sig_strength_hash.each do |key, value|
                    if key.to_s == "mtimestamp"
                      mtimestamp = DateTime.strptime(value.to_s, '%s')
                      gsm_identity.update_attribute(:mtimestamp, mtimestamp)
                    else
                      gsm_identity.update_attributes(gsm_sig_strength_hash)
                    end               
                  end          
                  
                  #m.gsm_signal_strengths << gsm_sig_strength 
                end 
                m.gsm_identities << gsm_identity
              end
              
              
              ####################################################
              #  WCDMA IDENTITY
              #  
              ####################################################
              #puts cell_info.inspect
              if cell_info.mCellIdentityWcdma && !cell_info.mCellIdentityWcdma.empty?
                wcdma_identity = WcdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp}) 
                ingest_wcdma_identity_hash ={}            
                ingest_wcdma_identity_hash = cell_info.mCellIdentityWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_identity.respond_to?k.downcase.to_s}.to_h           
                wcdma_identity.update_attributes(ingest_wcdma_identity_hash) 
                puts "...adding mCellIdentityWcdma data #{ingest_wcdma_identity_hash}"
                 
                if cell_info.mCellSignalStrengthWcdma && !cell_info.mCellSignalStrengthWcdma.empty?
                  #wcdma_sig_strength = WcdmaSignalStrength.new({}) 
                  wcdma_sig_strength_hash ={}            
                  wcdma_sig_strength_hash = cell_info.mCellSignalStrengthWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_identity.respond_to?k.downcase.to_s}.to_h           
                  wcdma_identity.update_attributes(wcdma_sig_strength_hash) 
                  wcdma_sig_strength_hash.each do |key, value|
                    if key.to_s == "mtimestamp"
                      mtimestamp = DateTime.strptime(value.to_s, '%s')
                      wcdma_identity.update_attribute(:mtimestamp, mtimestamp)
                    else
                      wcdma_identity.update_attributes(wcdma_sig_strength_hash)
                    end               
                  end   
                  
                  #m.wcdma_signal_strengths << wcdma_sig_strength 
                end
                m.wcdma_identities << wcdma_identity
              end
              
              ####################################################
              #  CDMA IDENTITY
              #  
              ####################################################
              #puts cell_info.inspect
              if cell_info.mCellIdentityCdma && !cell_info.mCellIdentityCdma.empty?           
                cdma_identity = CdmaIdentity.new({:mregistered => cell_info.mRegistered, :mtimestamp => cell_info.mTimeStamp})             
                ingest_cdma_identity_hash ={}            
                ingest_cdma_identity_hash = cell_info.mCellIdentityCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_identity.respond_to?k.downcase.to_s}.to_h                         
                cdma_identity.update_attributes(ingest_cdma_identity_hash) 
                puts "...adding mCellIdentityCdma data #{ingest_cdma_identity_hash}"
                #m.cdma_identities << cdma_identity 
                if cell_info.mCellSignalStrengthCdma && !cell_info.mCellSignalStrengthCdma.empty?
                  #cdma_sig_strength = CdmaSignalStrength.new({}) 
                  cdma_sig_strength_hash ={}            
                  cdma_sig_strength_hash = cell_info.mCellSignalStrengthCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_identity.respond_to?k.downcase.to_s}.to_h           
                  cdma_identity.update_attributes(cdma_sig_strength_hash) 
                  cdma_sig_strength_hash.each do |key, value|
                    if key.to_s == "mtimestamp"
                      mtimestamp = DateTime.strptime(value.to_s, '%s')
                      cdma_identity.update_attribute(:mtimestamp, mtimestamp)
                    else
                      cdma_identity.update_attributes(cdma_sig_strength_hash)
                    end               
                  end   
                  
                  #m.cdma_signal_strengths << cdma_sig_strength 
                end 
                m.cdma_identities << cdma_identity     
              end
              
              ####################################################
              #  LTE Signal Strength 
              #  
              ####################################################
              #puts cell_info.mCellSignalStrengthLte
             
              
              ####################################################
              #  GSM Signal Strength 
              #  
              ####################################################
              #puts cell_info.mCellSignalStrengthGsm
              
              
              ####################################################
              #  WCDMA Signal Strength 
              #  
              ####################################################
              #puts cell_info.inspect
             
              
              ####################################################
              #  CDMA Signal Strength 
              #  
              ####################################################
              #puts cell_info.inspect
              
            end #for loop
         
          
          c.save
          m.save
          c.metrics<<m
          return c.save
        else
          return false      
        end #c.valid?
      end  #with_lock      
  end
  
  def success_upload(conditions)
    render json: {
      status: "sucess",
      code: 200,
      message: "ceated cell upload for device_id #{conditions[:device_id]}",
      head: :no_content
    }, status: 200, content_type: 'application/json'
  end
  
  def ingest_error
    render json: {
      status: 422,
      error: :unprocessable_entity,
      message: 'Cell info not uploaded.'
    }, status: 422, content_type: 'application/json'
  end

  def cell_info_params
    # whitelist params
    params.permit(:device_id, :cellinfo, :location, :ping, :network_state, :line1number, :report_type, :timestamp, :format)
  end

  def set_cell_info
    @cell = Cell.find(params[:id])
  end
  
 
  def set_page
     @page = case params[:page]
     when params[:page].nil?
       1
     when params[:page].to_i < 0 || params[:page].to_i == 0
       1
     else       
       params[:page] || 1 
     end
       
  end
end
