class MedicationsController < ApplicationController
  include MedicationListApiHelper

  before_action :med_query, only: [:new]
  before_action :unauthorized_location

  def index
    medications = MedicationName.where(location: @location_param).order("name ASC")
    @medications = medications.paginate(page: params[:page], per_page: 50)
    if search_params
      @medications = medications.search_medication(search_params).paginate(page: params[:page], per_page: 50)
      @no_results = "No medication found" if @medications.blank?
    end

    render json: MedicationName.where(location: client_medication_autocomplete_params) if client_medication_autocomplete_params
  end

  def new
    @medication = Medication.new
    5.times { @medication.medication_names.build }
    @current_search = "Current search:" if @medication_param.present?
  end

  def create
    # medication_name_param returns all the medication_name.name values that are NOT blank.
    medication_name_param = params[:medication]["medication_names_attributes"].values.map { |med| med["name"] }.compact_blank
    @medication = Medication.new(medication_params)
    @medication.medication_names.each { |med| med.location = @location_param }
    respond_to do |format|
      # confirming there are NO duplicate med_names on create
      if medication_name_param.uniq.length == medication_name_param.length && @medication.save
        if params[:commit] == "Save and Return to Index"
          format.html { redirect_to medications_path(location: @location_param), notice: "Medication/s successfully added" }
          format.json { render :index, status: :created, location: @medication }
        else
          format.html { redirect_to new_medication_path(location: @location_param), notice: "Medication/s successfully added" }
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
    params.require(:medication).permit(medication_names_attributes: [:id, :name])
  end

  def search_params
    params.require(:search) if @search_param.present?
  end

  def client_medication_autocomplete_params
    if params[:medication_search] == "true"
      params.require(:medication_search)
      params.require(:medication_location)
    end
  end
end
