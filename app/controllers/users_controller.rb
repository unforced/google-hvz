class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :correct_or_admin_user?, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if current_user.admin?
      params = admin_user_params
    else
      params = user_params
    end
    respond_to do |format|
      if @user.update(params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:ldap, :email, :name, :phone_number)
    end

    def admin_user_params
      params.require(:user).permit(:ldap, :email, :name, :phone_number, :admin)
    end
end
