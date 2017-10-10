class ApplicationController < ActionController::API

  include Response
  include ExceptionHandler
  protect_from_forgery prepend: true
end
