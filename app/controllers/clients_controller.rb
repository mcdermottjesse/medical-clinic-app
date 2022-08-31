class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :skip_validation_health_card, :skip_validation_consent, only: [:update]
  before_action :health_card_checkbox_checked, only: [:edit]

  def index
    @location_param == "All Locations" ? clients = Client.all.order("last_name ASC") : clients = Client.where(location: @location_param).order("last_name ASC")
    @clients = clients.paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    skip_validation_health_card
    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path(@client, location: @client.location), notice: "Client successfully created" }
        format.json { render :index, status: :created, location: @client }
      else
        flash.now[:alert] = "There was an error creating the Client"
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path(location: @client.location), notice: "Client successfully updated" }
        format.json { render :index, status: :ok, location: @client }
      else
        flash.now[:alert] = "There was an error updating the Client"
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      if @client.destroyed?
        format.html { redirect_to clients_path(location: @location_param), notice: "Client successfully destroyed" }
        format.json { head :no_content }
      else
        flash.now[:alert] = "There was an error deleting the Client"
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def client_params
    params.require(:client).permit(
      # client_code is auto generated
      :first_name,
      :last_name,
      :dob,
      :pronoun,
      :other_pronoun,
      :health_card_number,
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

  def skip_validation_health_card
    @client.skip_health_card_validation = true if params["client"]["valid_health_card"].eql?("1")
  end

  def skip_validation_consent
    @client.skip_consent_validation = true
  end

  def health_card_checkbox_checked
    @health_card_number_present_check = @client.health_card_number.blank? && @client.health_card_number_validation.blank?
    @health_card_expiry_present_check = @client.health_card_expiry.blank? && @client.health_card_expiry_validation.blank?
  end
end
