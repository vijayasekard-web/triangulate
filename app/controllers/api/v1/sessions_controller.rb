class Api::V1::SessionsController < Api::V1::BaseController

  # skip_before_action :authenticate_warden, only: [:new, :create]
  skip_before_action :verify_authenticity_token

  def create
    render json: {user_name: current_user.email}
  end

end
