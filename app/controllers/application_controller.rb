require "application_responder"

class ApplicationController < ActionController::Base
  include ActionController::MimeResponds

  self.responder = ApplicationResponder
  respond_to :html
end
