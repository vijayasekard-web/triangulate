class Api::V1::BaseController < Users::SessionsController

  include UsersHelper
  # Doorkeeper code
  before_action :doorkeeper_authorize!
  #respond_to :json

end
