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
      
      dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:timestamp])
      if dsl && dsl.extract       
        
        json_response(success_upload(conditions), :success)
      else
        json_response(invalid_params, :error)
        
      end
    else
      
      json_response(invalid_params, :error)
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

  def success_upload(conditions)
    render json: {
      status: "sucess",
      code: 200,
      message: "ceated cell upload for device_id #{conditions[:device_id]}",
      head: :no_content
    }, status: 200, content_type: 'application/json'
  end
  
  def invalid_params
    render json: {
      status: 4000,
      error: :unprocessable_entity,
      message: 'Cell info not uploaded.  device_id, cellinfo, location, ping, timestamp is required.'
    }, status: 4000, content_type: 'application/json'
  end

  def cell_info_params
    # whitelist params
    params.permit(:device_id, :cellinfo, :location, :ping, :timestamp, :format)
  end

  def set_cell_info
    @cell = Cell.find(params[:id])
  end
  
end
