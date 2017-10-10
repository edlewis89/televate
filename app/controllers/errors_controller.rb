class ErrorsController < ApplicationController
  def not_found
    render json: {
      status: 404,
      error: :not_found,
      message: 'Where did the 403 errors go'
    }, status: 404
  end

  def internal_server_error
    render json: {
      status: 500,
      error: :internal_server_error,
      message: 'Houston we have a problem'
    }, status: 500
  end
  
  def unprocessable
    render json: {
      status: 422,
      error: :unprocessable_entity,
      message: 'Unprocessable cell info.  Invalid authenticity token'
    }, status: 422
  end
  def invalid_params
    render json: {
      status: 4000,
      error: :unprocessable_entity,
      message: 'Cell info not uploaded.  device_id, cellinfo, location, ping, timestamp is required.'
    }, status: 4000
  end
end