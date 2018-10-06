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

  private

  def professional_params
    params.require(:professional).permit(:profession_type_id, :user_id, :license_id,
       :postal_code, :radius)
  end

  def professional_update_params
    params.require(:professional).permit(:id,:license_id, :is_active, :postal_code, :radius)
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
