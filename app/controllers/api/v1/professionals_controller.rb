class Api::V1::ProfessionalsController < Api::V1::BaseController

  include ApiHelper

  skip_before_action :verify_authenticity_token
  # skip_before_action :doorkeeper_authorize!, only: [:create]

  format 'json'
  layout false

  def create
    @professional = Professional.new(professional_params)

    respond_to do |format|
      if @professional.save
        format.json { render :show, status: :created, location: @professional }
      else
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    if @professional = Professional.find(professional_update_params[:id])
      respond_to do |format|
        if @professional.update_attributes(professional_update_params)
          format.json { render :show, status: :created, location: @professional }
        else
          respond_with_validation_errors(@professional.errors)
        end
      else
        #respond_with_resource_not_found(professional)
      end
    end
  end

  def find_professional
    begin
      work_date = Date.parse find_professional_params[:start_at]
      professional_not_available = Schedule.where(work_date: work_date).where.
        not("start_at >= ? OR end_at <= ?", find_professional_params[:end_at],
          find_professional_params[:start_at]).distinct.pluck(:professional_id)
      @available_professional = Professional.where.not(id: professional_not_available)
      if is_gender_valid?(find_professional_params[:gender])
        @available_professional = @available_professional.joins(:user).where("users.gender = ?", find_professional_params[:gender])
      end
      @professional = @available_professional.first
      if address_id.present?
        @address = Address.find(address_id)
      else
        @address = Address.create!(find_professional_address_attributes)
      end
      respond_to do |format|
        if @professional.present?
          format.json { render :find, status: :created, location: @professional }
        else
          format.json { render json: {errors: "No professional found"}, status: :not_found }
        end
      rescue StandardError => error
        error.backtrace
        format.json { render json: {errors: "Unexpected_error"}, status: :internal_server_error }
      end
    end
  end

  private

  def professional_params
    params.require(:professional).permit(:profession_type_id, :user_id, :license_id,
       :postal_code, :radius)
  end

  def professional_update_params
    params.require(:professional).permit(:id,:license_id, :is_active, :postal_code,
      :radius)
  end

  def find_professional_params
    params.require(:professional).permit(:start_at, :end_at, :gender, addresses_attributes: addresses_attributes)
  end

  def address_id
    find_professional_params[:addresses_attributes][:id]
  end

  def find_professional_address_attributes
    find_professional_params[:addresses_attributes].merge(user_id: current_user.id)
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

  def is_gender_valid?(gender)
    gender.present? && ['Male', 'Female'].include?(gender)
  end
end


  # def create
  #   super do |professional|
  #     @professional = professional
  #     puts "professional email is #{professional.first_name}"
  #   end
  #    render json: {professional_name: "hi", first_name: "Hi"}
  #   # render json: {professional_name: @professional.email, first_name: @professional.first_name}.to_json, status: :ok
  # end
