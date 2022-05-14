class Admin::InvitationsController < Devise::InvitationsController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(invitation_params.merge(password: "temporary"))
    respond_to do |format|
      if @user.valid?
        @user = User.invite!(invitation_params.to_h)
        format.html { redirect_to authenticated_root_path, notice: "User was successfully invited." }
        format.json { render :index, status: :created, location: @user }
      else
        flash[:alert] = "Unable to save the User: #{@user.errors.full_messages.join(", ")}."
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private

  def invitation_params
    params.require(:user).permit(:email, :first_name, :last_name, :account_type, :location)
  end
end