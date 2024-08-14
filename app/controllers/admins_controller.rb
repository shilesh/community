class AdminsController < ApplicationController

  before_action :set_admin, only: %i[ edit update destroy change_password ]
  before_action :authenticate_user!, except: [:new, :create]

  # GET /admins/1
  def show
    @current = Admin.find("#{session[:user_id]}")
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    respond_to do |format|
      format.html 
      format.json { render json: @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @form = params[:form]
  end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Admin was successfully created." }
        format.json { render json: @admin, status: :created, location: @admin }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  def update
    if @admin.update(admin_params)
      respond_to do |format|
        format.html { redirect_to @admin, notice: "Admin was successfully updated." }
        format.json { render json: @admin, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_password
    if @admin.authenticate(params[:old_password])
        @admin.password = params[:new_password]
      if @admin.save
        redirect_to @admin, notice: "Password changed succcessfully"
      else 
        redirect_to @admin, notice: "Password change failed, please try again"
      end
    else 
      redirect_to @admin, notice: "Failed, Must enter correct Password"
    end 
  end  

  # DELETE /admins/1
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Account deleted successfully." }
      format.json { head :no_content }
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

