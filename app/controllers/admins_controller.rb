# class AdminsController < ApplicationController
#   before_action :set_admin, only: %i[ show edit update destroy ]

#   # GET /admins
#   def index
#     @admins = Admin.all
#   end

#   # GET /admins/1
#   def show
#   end

#   # GET /admins/new
#   def new
#     @admin = Admin.new
#   end

#   # GET /admins/1/edit
#   def edit
#   end

#   # POST /admins
#   def create
#     @admin = Admin.new(admin_params)

#     if @admin.save
#       redirect_to @admin, notice: "Admin was successfully created."
#     else
#       render :new, status: :unprocessable_entity
#     end
#   end

#   # PATCH/PUT /admins/1
#   def update
#     if @admin.update(admin_params)
#       redirect_to @admin, notice: "Admin was successfully updated.", status: :see_other
#     else
#       render :edit, status: :unprocessable_entity
#     end
#   end

#   # DELETE /admins/1
#   def destroy
#     @admin.destroy!
#     redirect_to admins_url, notice: "Admin was successfully destroyed.", status: :see_other
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_admin
#       @admin = Admin.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def admin_params
#       params.require(:admin).permit(:name, :mobile, :password_digest)
#     end
# end


class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]

  # GET /admins
  def index
    @admins = Admin.all
    respond_to do |format|
      format.html 
      format.json { render json: @admins }
    end
  end

  # GET /admins/1
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @admin }
    end
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
    respond_to do |format|
      format.html 
      format.json { render json: @admin }
    end
  end

  # POST /admins
  def create
    @admin = Admin.new(admin_params)

    if @admin.save
      respond_to do |format|
        format.html { redirect_to @admin, notice: "Admin was successfully created." }
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

  # DELETE /admins/1
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: "Admin was successfully destroyed." }
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
      params.require(:admin).permit(:name, :mobile, :password_digest)
    end
end

