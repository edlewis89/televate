class ErrorsController < ApplicationController
  def not_found
    render json: {
      status: 404,
      error: :not_found,
      message: 'Where did the 403 errors go'
    }, status: 404, content_type: 'application/json'
  end

  def internal_server_error
    render json: {
      status: 500,
      error: :internal_server_error,
      message: 'Houston we have a problem'
    }, status: 500, content_type: 'application/json'
  end
  
  def unprocessable
    render json: {
      status: 422,
      error: :unprocessable_entity,
      message: 'Unprocessable cell info.  Invalid authenticity token'
    }, status: 422, content_type: 'application/json'
  end
  
end