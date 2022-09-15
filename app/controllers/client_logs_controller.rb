class ClientLogsController < ApplicationController
  before_action :set_client
  before_action :set_client_log, only: [:edit, :update]

  def index
    @client_logs = ClientLog.where(client_id: @client).order('updated_at DESC').paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @client_log = ClientLog.new
  end

  def create
    @client_log = ClientLog.new(client_log_params)
    @client_log.user_id = current_user.id # add this logic to model?
    @client_log.client_id = @client.id # add this logic to model?
    respond_to do |format|
      if @client_log.save
        format.html { redirect_to client_client_logs_path(@client, location: @location_param), notice:  "Client Log for #{@client.full_name} successfully created"}
        format.json {render :index, status: :ok, location: @client_log }
      else
        flash.now[:alert] = "There was an error creating the Client Log"
        format.html { render :new }
        format.json { render json: @client_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @client_log.user_id = current_user.id # add this logic to model?
    respond_to do |format|
      if @client_log.update(client_log_params)
        format.html { redirect_to client_client_logs_path(@client, location: @location_param), notice:  "Client Log for #{@client.full_name} successfully updated"}
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
      :nurse_log
    )

  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_client_log
    @client_log = ClientLog.find(params[:id])
  end
end