require 'dsl'

class API::V1::UploadController < ApplicationController
  
  
  # GET /cell_info
  def index
    # @cell_info = CellInfo.all
    # json_response(@cell_info)
  end

  # POST /upload
  def create
    #puts "Creating cell info ..."
    # columns 1: device_id
    # columns 2: cellInfo
    # columns 3: location
    # columns 4: timestamp
    
    if cell_info_params
      puts "Creating cell info ... "
      #dsl = CellInfo::Dsl.new(params[:device_id], params[:cellinfo], params[:location], params[:ping], params[:timestamp])
      #dsl.extract
      #json_response(@cell_info, :created)
    else
      render json: {status: "error", code: 4000, message: "device_id, cellinfo, location, ping, timestamp is required."}
    end
    
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
