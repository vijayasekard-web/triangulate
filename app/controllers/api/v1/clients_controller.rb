class Api::V1::ClientsController < Api::V1::BaseController

  include ApiHelper

  skip_before_action :verify_authenticity_token
  # skip_before_action :doorkeeper_authorize!, only: [:create]

  format 'json'
  layout false

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.json { render :show, status: :created, location: @client }
      else
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @client = Client.find(client_update_params[:id])
      respond_to do |format|
        if @client.update_attributes(client_update_params)
          format.json { render :show, status: :created, location: @client }
        else
          respond_with_validation_errors(@client.errors)
        end
      else
        #respond_with_resource_not_found(client)
      end
    end
  end

  private

  def client_params
    params.require(:client).permit(:client_type, :user_id, :facility,
       :health_card)
  end

  def client_update_params
    params.require(:client).permit(:id, :client_type, :facility, :health_card)
  end
end
