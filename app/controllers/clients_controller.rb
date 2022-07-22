class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path(@client, location: @location_param), notice: "Save successfully" }
        format.json { render :index, status: :created, location: @client }
      else
        flash[:alert] = "Unable to save the Client: #{@client.errors.full_messages.join(", ")}."
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path(location: @location_param), notice: "Successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def client_params
    params.require(:client).permit(
      # client_code to be auto generated
      :first_name,
      :last_name,
      :dob,
      :pronoun,
      :other_pronoun,
      :healthcard_number,
      :health_card_expiry,
      :email,
      :phone_number,
      :emergency_contact_name,
      :emergency_contact_info,
      :location,
      :bed_number,
      :general_info,
      :consent
    )
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
