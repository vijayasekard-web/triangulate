class Api::V1::AppointmentsController < Api::V1::BaseController

  include ApiHelper

  skip_before_action :verify_authenticity_token

  format 'json'
  layout false

  def create
    @appointment = Appointment.new(appointment_params)

    respond_to do |format|
      if @appointment.save
        format.json { render :show, status: :created, location: @appointment }
      else
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @appointment = Appointment.find(appointment_update_params[:id])
      respond_to do |format|
        if @appointment.update_attributes(appointment_update_params)
          format.json { render :show, status: :created, location: @appointment }
        else
          respond_with_validation_errors(@appointment.errors)
        end
      else
        #respond_with_resource_not_found(appointment)
      end
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:professional_id, :client_id, :appointment_type,
      :status, :rating, :profession_type_id, :fees, :start_at, :end_at, :initiated_by, :review, :address_id)
  end

  def appointment_update_params
    params.require(:appointment).permit(:id, :appointment_type, :status, :rating,
      :fees, :start_at, :end_at, :initiated_by, :review, :address_id)
  end
end
