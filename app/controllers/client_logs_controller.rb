class ClientLogsController < ApplicationController
  before_action :set_client, :client_log_type
  before_action :set_client_log, only: [:edit, :update]
  before_action :set_log_date, :user_association, only: [:update]

  def index
    @nurse_log ? client_log = ClientLog.where.not(nurse_log: nil) : client_log = ClientLog.where.not(doctor_log: nil)
    @client_logs = client_log.where(client_id: @client, log_date: @log_date_param).order('updated_at DESC').paginate(page: params[:page], per_page: 1)
  end

  def show
  end

  def new
    @client_log = ClientLog.new
    3.times {@client_log.medications.build}
  end


  def create
    @client_log = ClientLog.new(client_log_params)
    user_association
    client_association
    set_log_date
    respond_to do |format|
      if @client_log.save!
        format.html { redirect_to client_client_logs_path(@client, location: @location_param, log_type: @client_log_param, log_date: @log_date_param), notice:  "Client Log for #{@client.full_name} successfully created"}
        format.json {render :index, status: :ok, location: @client_log }
      else
        flash.now[:alert] = "There was an error creating the Client Log"
        format.html { render :new}
        format.json { render json: @client_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @client_log.update(client_log_params)
        format.html { redirect_to client_client_logs_path(@client, location: @location_param, log_type: @client_log_param, log_date: @log_date_param), notice:  "Client Log for #{@client.full_name} successfully updated"}
        format.json {render :index, status: :ok, location: @client_log }
      else
        flash.now[:alert] = "There was an error updating the Client Log"
        format.html { render :edit }
        format.json { render json: @client_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

  def client_log_params
    params.require(:client_log).permit(
      :doctor_log,
      :nurse_log,
      medications_attributes: [:name, :dosage_amount, :dosage_unit]
    )
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_client_log
    @client_log = ClientLog.find(params[:id])
  end

  def set_log_date
    @client_log.log_date = @log_date_param
  end

  def user_association
    @client_log.user_id = current_user.id 
  end

  def client_association
    @client_log.client_id = @client.id
  end

  def client_log_type
    @client_log_param == 'nurse log' ? @nurse_log = 'nurse log' : @doctor_log = 'doctor log' 
  end
end