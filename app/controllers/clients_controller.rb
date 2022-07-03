class ClientsController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 6)
  end

  def show
  end

  def new
  end

  def create
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

  def set_client
    Client.find(params[:id])
  end
end
