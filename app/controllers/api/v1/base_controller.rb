class Api::V1::BaseController < Users::SessionsController

  include UsersHelper
  # Doorkeeper code
  before_action :doorkeeper_authorize!
  #respond_to :json
  before_action :set_user_time_zone

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end
end
