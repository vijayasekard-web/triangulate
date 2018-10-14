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

  def add_schedule
    work_date = Date.parse schedule_params[:start_date]
    @schedule = Schedule.create(professional_id: schedule_params[:professional_id],
      work_date: work_date, start_at: schedule_params[:start_date],
      end_at: schedule_params[:end_date], description: schedule_params[:desc])
    respond_to do |format|
     format.json { render :show, status: :ok}
    end
  end

  private

  def schedule_params
    params[:schedule]
  end
end
