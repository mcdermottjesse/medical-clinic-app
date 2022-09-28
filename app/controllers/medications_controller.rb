class MedicationsController < ApplicationController
  include MedicationListApiHelper

  before_action :med_query_one, only: [:new]

  def index
    @medications = Medication.where(location: @location_param)
  end

  def new
    @medication = Medication.new
  end

  def create
    @medication = Medication.new(medication_params)
    respond_to do |format|
      if @medication.save
        format.html { redirect_to medications_path(location: @medication.location), notice: "#{@medication.name} medication successfully created" }
        format.json { render :index, status: :created, location: @medication }
      else
        flash.now[:alert] = "There was an error creating the medication"
        format.html { render :new }
        format.json { render json: @medication.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def medication_params
    params.require(:medication).permit(:name)
  end
end
