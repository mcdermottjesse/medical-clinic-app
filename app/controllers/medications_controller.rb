class MedicationsController < ApplicationController
  include MedicationListApiHelper

  before_action :med_query, only: [:new]

  def index
    @medications = Medication.where(location: @location_param)
  end

  def new
    @medication = Medication.new
    5.times { @medication.medication_names.build }
    @current_search = "Current search:" if @medication_param.present?
  end

  def create
    # medication_name_param returns all the medication_name.name values that are NOT blank.
    medication_name_param = params[:medication]["medication_names_attributes"].values.map{ |med| med["name"] }.compact_blank
    @medication = Medication.new(medication_params)
    respond_to do |format|
      if medication_name_param.uniq.length == medication_name_param.length && @medication.save
        if params[:commit] == "Save"
          format.html { redirect_to medications_path(location: @medication.location), notice: "Medication successfully created" }
          format.json { render :index, status: :created, location: @medication }
        else
          format.html { redirect_to new_medication_path(location: @medication.location), notice: "Medication successfully created" }
          format.json { render :new, status: :created, location: @medication }
        end
      else
        flash.now[:alert] = "There was an error creating the medication. Medication may already be added. Medication cannot be duplicated"
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def medication_params
    params.require(:medication).permit(medication_names_attributes: [:id, :name]).merge(location: @location_param)
  end
end
