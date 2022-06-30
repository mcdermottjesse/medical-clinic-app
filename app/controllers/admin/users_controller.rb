class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_resource

  def index
    @location_param == "All Locations" ? users = User.all : users = User.where(location: @location_param)

    if user_autocomplete_params
      user_suggestions = User.select(:first_name, :last_name).distinct
      if user_autocomplete_params == "All Locations"
        @users = user_suggestions.order("last_name ASC")
      else
        @users = user_suggestions.where(location: user_autocomplete_params).order("last_name ASC")
      end
      render :json => @users
    end

    if search_params
      @users = users.search_record(search_params).paginate(page: params[:page], per_page: 6)
    else
      @users = users.paginate(page: params[:page], per_page: 6)
    end
  end

  def update
    #password formatting only applies to invitations/edit and passwords/edit
    @user.skip_password_validation = true
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path(location: @location_param), notice: "User succesfully updated" }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { redirect_to edit_admin_user_path(@user), alert: "Unable to save the User: #{@user.errors.full_messages.join(", ")}." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path(location: @location_param), notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :account_type, :location)
  end

  def search_params
    params.require(:search) if params[:search].present?
  end

  def user_autocomplete_params
    if params[:user_search] == "true"
      params.require(:user_search)
      params.require(:user_location)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_resource
    authorize [:admin, :user]
  end
end
