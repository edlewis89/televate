class ApplicationController < ActionController::API

  include Response
  include ExceptionHandler
  include TableListingHelper
  #protect_from_forgery prepend: true
end
