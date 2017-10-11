require 'dsl'

class API::V1::UploadController < ApplicationController
  
  
  # GET /cell_info
  def index
    @cell = Cell.all
    json_response(@cell)
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
      
      @dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:timestamp])
      
      if @dsl
        if @dsl.extract                   
          success_upload(conditions)
        else
          ingest_error
        end
        
      else          
        params_nil
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
  
  def extract
  
      begin
        puts "DSL::extracting ... device id #{@dsl.device_id}"
        c = nil
        c = Cell.new({:cell_device_id => @dsl.device_id}) 
        puts "created cell ... #{c.valid?}"
        if c && c.valid? 
          
          cell_ping = Ping.new(@dsl.cell_ping.each_pair.map{|k, v| [k.downcase, v]}.to_h)
          cell_location = CellLocation.new(@dsl.cell_location.each_pair.map{|k, v| [k.downcase, v]}.to_h)
          m = Metric.new({:cell_ping_id => cell_ping.id, 
              :cell_location_id => cell_location.id,
              :raw_cell_info => raw_cell_info.id
          })
          puts "Saving metric ... " 
                    
          for i in 0..@dsl.cell_info_size - 1 
            
            
            cell_identity_lte = CellIdentityLte.new(@dsl.lte_cell_identity(i).to_h)
            cell_identity_gsm = CellIdentityGsm.new(@dsl.gsm_cell_identity(i).to_h)
            cell_identity_wcdma = CellIdentityWcdma.new(@dsl.wcdma_cell_identity(i).to_h)
            cell_identity_cdma = CellIdentityCdma.new(@dsl.cdma_cell_identity(i).to_h)
            cell_sig_strength_lte = CellSignalStrengthLte.new(@dsl.lte_signal_strength(i).to_h)
            cell_sig_strength_gsm = CellSignalStrengthGsm.new(@dsl.gsm_signal_strength(i).to_h)
            cell_sig_strength_wcdma = CellSignalStrengthWcdma.new(@dsl.wcdma_signal_strength(i).to_h)
            cell_sig_strength_cdma = CellSignalStrengthCdma.new(@dsl.cdma_signal_strength(i).to_h)
            #raw_cell_info = RawCellInfo.new(@dsl.cell_info_data)
            m = Metric.new({:cell_identity_lte_id => cell_identity_lte.id, 
              :cell_identity_gsm_id => cell_identity_gsm.id,
              :cell_identity_wcdma_id => cell_identity_wcdma.id, 
              :cell_identity_cdma_id => cell_identity_cdma.id, 
              :cell_sig_strength_lte_id => cell_signal_strength_lte.id, 
              :cell_sig_strength_gsm_id => cell_signal_strength_gsm.id, 
              :cell_sig_strength_wcdma_id => cell_signal_strength_wcdma.id, 
              :cell_sig_strength_cdma_id => cell_signal_strength_cdma.id,
              #:cell_ping_id => cell_ping.id, 
              #:cell_location_id => cell_location.id,
              #:raw_cell_info => raw_cell_info.id
              })
            
            c.metrics << m
            if c.valid? 
              puts "Saving metric ... "
              return c.save
            else
              return false
            end       
          end #for loop
        else #if valid Cell
          false        
        end
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
