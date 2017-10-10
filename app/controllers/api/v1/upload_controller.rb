require 'dsl'

class API::V1::UploadController < ApplicationController
  
  
  # GET /cell_info
  def index
    # @cell_info = CellInfo.all
    # json_response(@cell_info)
  end

  # POST /create
  def create
    #puts "Creating cell info ..."
    # columns 1: device_id
    # columns 2: cellInfo
    # columns 3: location
    # columns 4: timestamp
    
    if cell_info_params
      #puts "Creating cell info ... "
      conditions = {}
      conditions[:device_id] = params[:device_id] unless params[:device_id].blank?
      conditions[:cellinfo] = params[:cellinfo] unless params[:cellinfo].blank?
      conditions[:location] = params[:location] unless params[:location].blank?
      conditions[:ping] = params[:ping] unless params[:ping].blank?
      conditions[:timestamp] = params[:timestamp] unless params[:timestamp].blank?
      
      dsl = CellInfo::Dsl.new(conditions[:device_id], conditions[:cellinfo], conditions[:location], conditions[:ping], conditions[:timestamp])
      if dsl && dsl.extract       
        json_response(success_upload(conditions), :success)
        
      end
    else
      
      json_response(invalid_params, :error)
    end
    
  end
  def success_upload(conditions)
    render json: {
      status: "sucess",
      code: 200,
      message: "ceated cell upload for device_id #{conditions[:device_id]}"
    }, status: 200, content_type: 'application/json'
  end


  # GET /cell_info/:id
  def show
    # json_response(@cell_info)
  end

  # PUT /cell_info/:id
  def update
    # @cell_info.update(cell_info_params)
    # head :no_content
  end

  # DELETE /cell_info/:id
  def destroy
    # @cell_info.destroy
    # head :no_content
  end

  private

  def cell_info_params
    # whitelist params
    params.permit(:device_id, :cellinfo, :location, :ping, :timestamp)
  end

  def set_cell_info
    # @cell_info = CellInfo.find(params[:id])
  end
  
end
