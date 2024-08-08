class AddressesController < ApplicationController
  before_action :set_address, only: %i[ show edit update destroy ]

  # GET /addresses
  def index
    @addresses = Address.all
    respond_to do |format|
      format.html 
      format.json { render json: @addresses }
    end
  end

  # GET /addresses/1
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @address }
    end
  end

  # GET /addresses/new
  def new
    @address = Address.new
    respond_to do |format|
      format.html 
      format.json { render json: @address }
    end
  end

  # GET /addresses/1/edit
  def edit
    respond_to do |format|
      format.html 
      format.json { render json: @address }
    end
  end

  # POST /addresses
  def create
    @address = Address.new(address_params)

    if @address.save
      respond_to do |format|
        format.html { redirect_to @address, notice: "Address was successfully created." }
        format.json { render json: @address, status: :created}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  def update
    if @address.update(address_params)
      respond_to do |format|
        format.html { redirect_to @address, notice: "Address was successfully updated." }
        format.json { render json: @address, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:address).permit(:member_id, :permanent, :communication, :permanent_zip, :communication_zip)
    end
end
