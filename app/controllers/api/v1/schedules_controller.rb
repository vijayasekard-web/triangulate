class Api::V1::SchedulesController < Api::V1::BaseController
  include ApiHelper

  skip_before_action :verify_authenticity_token

  format 'json'
  layout false

  def get_schedule
    @schedule = Schedule.where(professional_id: schedule_params[:professional_id]).
      where("work_date >= ? AND work_date <= ?", schedule_params[:start_date], schedule_params[:end_date])
    respond_to do |format|
     format.json { render :show, status: :ok}
    end
  end

  private

  def schedule_params
    params[:schedule]
  end
end
