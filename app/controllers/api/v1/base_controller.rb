class Api::V1::BaseController < Users::SessionsController

  # Doorkeeper code
  before_action :doorkeeper_authorize!
  #respond_to :json

  def current_user
  @current_user ||= if doorkeeper_token
                      User.find(doorkeeper_token.resource_owner_id)
                    else
                      warden.authenticate(scope: :user)
                    end
  end
end
