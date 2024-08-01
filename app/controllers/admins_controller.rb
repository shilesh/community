class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ edit update destroy edit_custom change_password ]
  before_action :authenticate_user!, except: [:new, :create]

  # GET /admins
  # def index
  #   @admins = Admin.all
  # end

  # GET /admins/1
  def show
    @current = Admin.find("#{session[:user_id]}")
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  def edit_custom
  end 

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to root_path, notice: "Account Created Successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /admins/1
  def update
    if @admin.update(admin_params)
      redirect_to @admin, notice: "Changes Saved Successfully", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_password
    if @admin.authenticate(params[:old_password])
        @admin.password = params[:new_password]
      if @admin.save
        redirect_to @admin, notice: "Password changed succcessfully"
      else 
        redirect_to edit_custom_admin_path(@admin), notice: "Password change failed, please try again"
      end
    else 
      redirect_to @admin, notice: "Failed, Must enter correct Password"
    end 
  end  

  # DELETE /admins/1
  def destroy
    if @admin.destroy!
      redirect_to root_path, notice: "Profile Deleted Successfully"
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:name, :mobile, :password)
    end
end
