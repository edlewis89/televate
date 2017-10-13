require 'dsl'

class API::V1::UploadController < ApplicationController
  
  
  # GET /cell_info
  def index
    @result = {}
    c = Cell.order("created_at").last
    
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

  # POST /create
  def create
    #puts "Creating cell info ..."
    # columns 1: device_id
    # columns 2: cellInfo
    # columns 3: location
    # columns 4: timestamp
    
    if cell_info_params
      
      conditions = {}
      conditions[:device_id] = params[:device_id] unless params[:device_id].blank?
      conditions[:cellinfo] = params[:cellinfo] unless params[:cellinfo].blank?
      conditions[:location] = params[:location] unless params[:location].blank?
      conditions[:ping] = params[:ping] unless params[:ping].blank?
      conditions[:timestamp] = params[:timestamp] unless params[:timestamp].blank?
      
      dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:timestamp])      
      if extract(dsl)                 
        success_upload(conditions)
      else
        ingest_error
      end      
    else
      params_invalid     
    end    
  end
  


  # GET /cell/:id
  def show
    set_cell_info
    json_response(@cell)
  end

  # PUT /cell/:id
  def update
    set_cell_info
    @cell.update(cell_info_params)
    head :no_content
  end

  # DELETE /cell/:id
  def destroy
    set_cell_info
    @cell.destroy
    head :no_content
  end

  private
  
  def extract(dsl)
    begin
      if dsl.device_id && !dsl.device_id.empty?
        ####################################################
        #  CELL
        #
        ####################################################  
        c = Cell.new({:cell_device_id => dsl.device_id})
        if c.valid?
          c.save
          puts "...Initialized Cell Object #{c.cell_device_id}"
          ####################################################
          #  METRIC
          #
          ####################################################   
          m = Metric.new({:ingest_timestamp => DateTime.now()})
          m.save
          puts "...Initialized Metric Object #{m.ingest_timestamp}"
          
          m.ingested_datum << IngestedDatum.new({:name => 'cell_info', :data => dsl.cell_info_object})
          m.ingested_datum << IngestedDatum.new({:name => 'cell_location', :data => dsl.cell_location_object}) 
          puts "...added raw data #{m.ingested_datum.size}"
          
          ####################################################
          #  PING
          #
          ####################################################         
          ping = Ping.new()
          ingest_ping_hash ={}
          ping_hash = {}
          ping_hash = dsl.cell_ping_object.each_pair.map{|k, v| [k.downcase, v]}.to_h unless dsl.cell_ping_object.nil?
          ingest_ping_hash=ping_hash.select{|k, v| ingest_ping_hash[k.downcase.to_sym]=v if ping.respond_to?k.downcase} unless ping_hash       
          #puts ingest_ping_hash
          m.create_ping(ingest_ping_hash)
          ####################################################
          #  LOCATION
          #
          #################################################### 
          
          puts "...adding location data #{dsl.cell_location_object}" unless dsl.cell_location_object.nil?
          location = Location.new()
          ingest_location_hash ={}
          location_hash={}
          location_hash = dsl.cell_location_object.each_pair.map{|k, v| [k.downcase, v]}.to_h unless dsl.cell_location_object.nil?
          puts "...location parse #{location_hash}" unless location_hash.nil?
          ingest_location_hash = location_hash.select{|k, v| ingest_location_hash[k.downcase]=v if location.respond_to?k.downcase.to_s} unless location_hash.nil? 
          puts "...ingest_location_hash parse #{ingest_location_hash}" unless location_hash.nil?
          location.update_attributes(ingest_location_hash)
          m.location_id = location.id
          puts "...ingest location data"
          ####################################################
          #  CELL INFO
          #
          #################################################### 
          
          dsl.cell_info_object.each do |cell_info|            
          
            ####################################################
            #  LTE IDENTITY
            #  
            #################################################### 
            if cell_info.mCellIdentityLte
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
          c.metrics<<m
          c.save
        else
          false
        end #c.valid?
      else
       false                    
      end #if device_id
    rescue StandardError => e
      puts "Error: #{e}"
      return false
    end
  end
  
  def success_upload(conditions)
    render json: {
      status: "sucess",
      code: 200,
      message: "ceated cell upload for device_id #{conditions[:device_id]}",
      head: :no_content
    }, status: 200, content_type: 'application/json'
  end
  
 def params_invalid
    render json: {
      status: 4000,
      error: :unprocessable_entity,
      message: 'Cell info not uploaded.  device_id, cellinfo, location, ping, timestamp is required.'
    }, status: 4000, content_type: 'application/json'
  end
  
  def params_nil
    render json: {
      status: 422,
      error: :unprocessable_entity,
      message: 'Cell info not uploaded.  device_id, cellinfo, location, ping, timestamp is required.'
    }, status: 422, content_type: 'application/json'
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
    params.permit(:device_id, :cellinfo, :location, :ping, :timestamp, :format)
  end

  def set_cell_info
    @cell = Cell.find(params[:id])
  end
  
end
