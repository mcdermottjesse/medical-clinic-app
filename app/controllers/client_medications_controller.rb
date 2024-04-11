class ClientMedicationsController < ApplicationController
  before_action :get_client_medication, :get_client, :get_client_log

  def destroy
    @client_medication.destroy
    respond_to do |format|
      if @client_medication.destroyed?
        format.html { 
          redirect_to edit_client_client_log_path(
            @client,
            @client_log, 
            location: @location_param, 
            log_type: @client_log_param, 
            log_date: @log_date_param
          ), 
          notice: "Medication removed" 
        }
        format.json { head :no_content }
      end
    end
  end

  private

  def get_client_medication
    @client_medication = ClientMedication.find(params[:id])
  end 

  def get_client
    @client = Client.find(params[:client_id])
  end

  def get_client_log
    @client_log = ClientLog.find(params[:client_log_id])
  end
end
