class Api::V1::UsersController < Api::V1::BaseController

  include UsersHelper
  include ApiHelper

  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!, only: [:create]

  format 'json'
  layout false

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if @user = User.find(user_update_params[:id])
      respond_to do |format|
        if @user.update_attributes(user_update_params)
          format.json { render :show, status: :created }
        else
          respond_with_validation_errors(@user.errors)
        end
      else
        #respond_with_resource_not_found(User)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :dob,
        :gender, :first_name, :last_name, :time_zone, addresses_attributes: addresses_attributes)
  end

  def user_update_params
    params.require(:user).permit(:id, :dob, :gender, :first_name, :last_name, :time_zone,
      addresses_attributes: addresses_attributes)
  end

  def addresses_attributes
    [
      :id,
      :user_id,
      :address_1,
      :address_2,
      :city,
      :province,
      :country,
      :postal_code,
      :favorite
    ]
  end
end



