class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_resource

  def index
   params[:location] == "All Locations" ?  users = User.all : users = User.where(location: params[:location])
   
    @users = users.paginate(page: params[:page], per_page: 6)
  end

  def update
    #password formatting only applies to invitations/edit and passwords/edit
    @user.skip_password_validation = true
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_path(location: params[:location]), notice: "User succesfully updated" }
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
      format.html { redirect_to admin_users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :account_type, :location)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_resource
    authorize [:admin, :user]
  end
end
