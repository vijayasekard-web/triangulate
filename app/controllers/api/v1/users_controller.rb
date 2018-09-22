class Api::V1::UsersController < Api::V1::BaseController

  include UsersHelper

  skip_before_action :verify_authenticity_token
  skip_before_action :doorkeeper_authorize!, only: [:create]

  format 'json'
  layout false

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render :show, status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :dob, :gender, :first_name, :last_name)
  end
end


  # def create
  #   super do |user|
  #     @user = user
  #     puts "User email is #{user.first_name}"
  #   end
  #    render json: {user_name: "hi", first_name: "Hi"}
  #   # render json: {user_name: @user.email, first_name: @user.first_name}.to_json, status: :ok
  # end
