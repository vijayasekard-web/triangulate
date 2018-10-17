class Api::V1::SchedulesController < Api::V1::BaseController
  include ApiHelper

  skip_before_action :verify_authenticity_token

  format 'json'
  layout false

  def create
    work_date = Date.parse schedule_params[:start_at]
    @schedule = Schedule.create(schedule_create_params.merge(work_date: work_date))
    respond_to do |format|
     format.json { render :show, status: :ok}
    end
  end

  def update
    work_date = Date.parse schedule_params[:start_at]
    if @schedule = Schedule.find(schedule_update_params[:id])
      respond_to do |format|
        if @schedule.update_attributes(schedule_update_params.merge(work_date: work_date))
          format.json { render :show, status: :created, location: @schedule }
        else
          respond_with_validation_errors(@schedule.errors)
        end
      else
        #respond_with_resource_not_found(professional)
      end
    end
  end

  def destroy
    begin
    @schedule = Schedule.find(schedule_params[:id])
      respond_to do |format|
        if @schedule.destroy
          format.json { render :show, status: :ok}
        else
          respond_with_validation_errors(@schedule.errors)
        end
      end
    rescue ActiveRecord::RecordNotFound => error
      error.backtrace
      respond_to do |format|
        format.json { render json: {errors: "Schedule not found"}, status: :not_found }
      end
    end
  end

  def get_schedule
    @schedule = Schedule.where(professional_id: schedule_params[:professional_id]).
      where("work_date >= ? AND work_date <= ?", schedule_params[:start_at], schedule_params[:end_at])
    respond_to do |format|
     format.json { render :show, status: :ok}
    end
  end

  private

  def schedule_create_params
    params.require(:schedule).permit(:professional_id, :start_at, :end_at,
       :description)
  end

  def schedule_update_params
    params.require(:schedule).permit(:id, :start_at, :end_at, :description)
  end

  def schedule_params
    params[:schedule]
  end
end
