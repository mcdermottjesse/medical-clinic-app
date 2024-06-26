class ClientsController < ApplicationController
  include ClientHelper

  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :skip_validation_health_card, :skip_validation_consent, only: [:update]
  before_action :health_card_checkbox_checked, only: [:edit]
  before_action :unauthorized_location, unless: :client_autocomplete_params

  def index
    @location_param == "All Locations" ? clients = Client.all.order("last_name ASC") : clients = Client.where(location: @location_param).order("last_name ASC")
    
    if client_autocomplete_params
      client_suggestions = Client.select(:first_name, :last_name).distinct
      if client_autocomplete_params == "All Locations"
        @clients = client_suggestions.order("last_name ASC")
      else
        @clients = client_suggestions.where(location: client_autocomplete_params).order("last_name ASC")
      end
      render :json => @clients
    end
    
    if search_params
      @clients = clients.search_record(search_params).paginate(page: params[:page], per_page: 6)
    else
      @clients = clients.paginate(page: params[:page], per_page: 6)
    end
  end

  def show
    display_content_if_present
    health_card_expiry_warning
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    skip_validation_health_card
    respond_to do |format|
      if @client.save
        format.html { redirect_to client_path(@client, location: @client.location), notice: "#{@client.full_name} successfully created" }
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
        format.html { redirect_to client_path(@client, location: @client.location), notice: "#{@client.full_name} successfully updated" }
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
      :avatar,
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

  def search_params
    params.require(:search) if @search_param.present?
  end

  def client_autocomplete_params
    if params[:client_search] == "true"
      params.require(:client_search)
      params.require(:client_location)
    end
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
