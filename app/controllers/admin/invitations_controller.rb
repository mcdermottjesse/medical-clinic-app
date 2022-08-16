class Admin::InvitationsController < Devise::InvitationsController
  before_action :authorize_resource, if: :user_signed_in? # check if user is signed in to invite a new user to set password
  def new
    @user = User.new
  end

  def create
    @user = User.new(invitation_params.merge(password: 'Temporary1!'))
    respond_to do |format|
      if @user.valid?
        @user = User.invite!(invitation_params.to_h)
        format.html { redirect_to authenticated_root_path, notice: 'User was successfully invited' }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private

  def invitation_params
    params.require(:user).permit(:email, :first_name, :last_name, :account_type, :location)
  end

  def authorize_resource
    authorize [:admin, :user]
  end
end