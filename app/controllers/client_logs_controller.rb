class ClientLogsController < ApplicationController
  def index
    @client = Client.find(params[:client_id])
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
  end
end