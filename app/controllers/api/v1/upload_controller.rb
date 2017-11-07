require 'dsl'

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
    #@cells = Cell.limit(CELLS_PER_PAGE).offset(@page * CELLS_PER_PAGE).order("created_at ASC") 
   
    
    #if @cells.size > 0
    #  @metrics = @cells.metrics     
    #end
    #respond_to do |format|
    #  format.html { render :partial => "report", notice: 'Task was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
    
  end

  # POST /create
  def create
    #puts "Creating cell info ..."
    # columns 1: device_id
    # column 2: line1number
    # columns 3: cellInfo
    # columns 4: location
    # columns 5: timestamp
    
    if cell_info_params
      
      conditions = {}
      conditions[:device_id] = params[:device_id] 
      conditions[:line1number] = params[:line1number] 
      conditions[:cellinfo] = params[:cellinfo] 
      conditions[:location] = params[:location]   
      conditions[:ping] = params[:ping] 
      conditions[:network_state] = params[:network_state] 
      conditions[:timestamp] = params[:timestamp] 
      #cell_device_id="", cell_line1number="", cell_info_data={}, cell_location_data={}, cell_ping_data={}, cell_timestamp={}       
      dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:line1number], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:network_state], conditions[:timestamp])      
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
          
          m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.ingested_json_data})
          m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.ingested_location_data})
          m.ingested_datum << IngestedDatum.new({:name => 'cell_ping', :data => dsl.ingested_ping_data})  
          m.ingested_datum << IngestedDatum.new({:name => 'cell_netstate', :data => dsl.ingested_netstate_data})  
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
          pp = Ping::Parser.new(ping_hash[:output])          
          ingest_ping_hash=pp.to_h unless ping_hash                 
          #ingest_ping_hash=ping_hash.select{|k, v| ingest_ping_hash[k.downcase.to_sym]=v if ping.respond_to?k.downcase} unless ping_hash       
          puts "...ingest_ping_hash parse #{ingest_ping_hash}" 
          ping.update_attributes(ingest_ping_hash)
          m.ping_id = ping.id
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
            netState.update_attributes(ingest_netstate_hash)
            m.network_state_id = netState.id
            
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
              m.cdma_identities << cdma_identity 
            end
            
            ####################################################
            #  LTE Signal Strength 
            #  
            ####################################################
            puts cell_info.mCellSignalStrengthLte
            if cell_info.mCellSignalStrengthLte
              lte_sig_strength = LteSignalStrength.new({}) 
              lte_sig_strength_hash ={}            
              lte_sig_strength_hash = cell_info.mCellSignalStrengthLte.each_pair.map{|k,v| [k.downcase, v] if lte_sig_strength.respond_to?k.downcase.to_s}.to_h           
              lte_sig_strength.update_attributes(lte_sig_strength_hash) 
              m.lte_signal_strengths << lte_sig_strength 
            end
            
            ####################################################
            #  GSM Signal Strength 
            #  
            ####################################################
            puts cell_info.mCellSignalStrengthGsm
            if cell_info.mCellSignalStrengthGsm
              gsm_sig_strength = GsmSignalStrength.new({}) 
              gsm_sig_strength_hash ={}            
              gsm_sig_strength_hash = cell_info.mCellSignalStrengthGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_sig_strength.respond_to?k.downcase.to_s}.to_h           
              gsm_sig_strength.update_attributes(gsm_sig_strength_hash) 
              m.gsm_signal_strengths << gsm_sig_strength 
            end
            
            ####################################################
            #  WCDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellSignalStrengthWcdma
              wcdma_sig_strength = WcdmaSignalStrength.new({}) 
              wcdma_sig_strength_hash ={}            
              wcdma_sig_strength_hash = cell_info.mCellSignalStrengthWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
              wcdma_sig_strength.update_attributes(wcdma_sig_strength_hash) 
              m.wcdma_signal_strengths << wcdma_sig_strength 
            end
            
            ####################################################
            #  CDMA Signal Strength 
            #  
            ####################################################
            #puts cell_info.inspect
            if cell_info.mCellSignalStrengthCdma
              cdma_sig_strength = CdmaSignalStrength.new({}) 
              cdma_sig_strength_hash ={}            
              cdma_sig_strength_hash = cell_info.mCellSignalStrengthCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
              cdma_sig_strength.update_attributes(cdma_sig_strength_hash) 
              m.cdma_signal_strengths << cdma_sig_strength 
            end     
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
            
            m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.ingested_json_data})
            m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.ingested_location_data}) 
            m.ingested_datum << IngestedDatum.new({:name => 'cell_ping', :data => dsl.ingested_ping_data}) 
            m.ingested_datum << IngestedDatum.new({:name => 'cell_netstate', :data => dsl.ingested_netstate_data})  
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
              pp = Ping::Parser.new(ping_hash[:output])          
              ingest_ping_hash=pp.to_h unless ping_hash                   
              #ingest_ping_hash=ping_hash.select{|k, v| ingest_ping_hash[k.downcase.to_sym]=v if ping.respond_to?k.downcase}       
              puts "...ingest_ingest_hash parse #{ingest_ping_hash}" 
              ping.update_attributes(ingest_ping_hash)
              m.ping_id = ping.id
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
              #puts "...location parse #{location_hash}" 
              ingest_location_hash = location_hash.select{|k, v| ingest_location_hash[k.downcase]=v if location.respond_to?k.downcase.to_s}  
              #puts "...ingest_location_hash parse #{ingest_location_hash}" 
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
              netState.update_attributes(ingest_netstate_hash)
              m.network_state_id = netState.id
              
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
              m.cdma_identities << cdma_identity 
              end
              
              ####################################################
              #  LTE Signal Strength 
              #  
              ####################################################
              #puts cell_info.mCellSignalStrengthLte
              if cell_info.mCellSignalStrengthLte && !cell_info.mCellSignalStrengthLte.empty?
              lte_sig_strength = LteSignalStrength.new({}) 
              lte_sig_strength_hash ={}            
              lte_sig_strength_hash = cell_info.mCellSignalStrengthLte.each_pair.map{|k,v| [k.downcase, v] if lte_sig_strength.respond_to?k.downcase.to_s}.to_h           
              lte_sig_strength.update_attributes(lte_sig_strength_hash) 
              m.lte_signal_strengths << lte_sig_strength 
              end
              
              ####################################################
              #  GSM Signal Strength 
              #  
              ####################################################
              #puts cell_info.mCellSignalStrengthGsm
              if cell_info.mCellSignalStrengthGsm && !cell_info.mCellSignalStrengthGsm.empty?
              gsm_sig_strength = GsmSignalStrength.new({}) 
              gsm_sig_strength_hash ={}            
              gsm_sig_strength_hash = cell_info.mCellSignalStrengthGsm.each_pair.map{|k,v| [k.downcase, v] if gsm_sig_strength.respond_to?k.downcase.to_s}.to_h           
              gsm_sig_strength.update_attributes(gsm_sig_strength_hash) 
              m.gsm_signal_strengths << gsm_sig_strength 
              end
              
              ####################################################
              #  WCDMA Signal Strength 
              #  
              ####################################################
              #puts cell_info.inspect
              if cell_info.mCellSignalStrengthWcdma && !cell_info.mCellSignalStrengthWcdma.empty?
              wcdma_sig_strength = WcdmaSignalStrength.new({}) 
              wcdma_sig_strength_hash ={}            
              wcdma_sig_strength_hash = cell_info.mCellSignalStrengthWcdma.each_pair.map{|k,v| [k.downcase, v] if wcdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
              wcdma_sig_strength.update_attributes(wcdma_sig_strength_hash) 
              m.wcdma_signal_strengths << wcdma_sig_strength 
              end
              
              ####################################################
              #  CDMA Signal Strength 
              #  
              ####################################################
              #puts cell_info.inspect
              if cell_info.mCellSignalStrengthCdma && !cell_info.mCellSignalStrengthCdma.empty?
              cdma_sig_strength = CdmaSignalStrength.new({}) 
              cdma_sig_strength_hash ={}            
              cdma_sig_strength_hash = cell_info.mCellSignalStrengthCdma.each_pair.map{|k,v| [k.downcase, v] if cdma_sig_strength.respond_to?k.downcase.to_s}.to_h           
              cdma_sig_strength.update_attributes(cdma_sig_strength_hash) 
              m.cdma_signal_strengths << cdma_sig_strength 
              end     
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
    params.permit(:device_id, :cellinfo, :location, :ping, :network_state, :line1number, :timestamp, :format)
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
