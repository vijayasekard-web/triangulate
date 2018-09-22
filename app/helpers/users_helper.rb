module UsersHelper
  def current_user
    @current_user ||= if doorkeeper_token
                      User.find(doorkeeper_token.resource_owner_id)
                    else
                      warden.authenticate(scope: :user)
                    end
  end
end
