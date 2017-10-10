class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  protect_from_forgery prepend: true
end
