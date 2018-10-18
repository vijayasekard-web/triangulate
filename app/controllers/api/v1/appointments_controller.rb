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

  def get_professional_appointments
    @appointment = Appointment.where(professional_id: get_professional_appointments_params[:professional_id]).
      where("work_date >= ? AND work_date <= ?", get_professional_appointments_params[:start_at],
        get_professional_appointments_params[:end_at])
    respond_to do |format|
     format.json { render :show, status: :ok}
    end
  end

  def get_client_appointments
    @appointment = Appointment.where(client_id: get_client_appointments_params[:client_id]).
      where("work_date >= ? AND work_date <= ?", get_client_appointments_params[:start_at],
        get_client_appointments_params[:end_at])
    respond_to do |format|
     format.json { render :show, status: :ok}
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

  def get_professional_appointments_params
    params.require(:appointment).permit(:professional_id, :start_at, :end_at)
  end

  def get_client_appointments_params
    params.require(:appointment).permit(:client_id, :start_at, :end_at)
  end
end
