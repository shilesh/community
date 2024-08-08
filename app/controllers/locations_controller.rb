class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]

  # GET /locations
  def index
    @locations = Location.all
    respond_to do |format|
      format.html 
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  def show
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    respond_to do |format|
      format.html 
      format.json { render json: @location }
    end
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      respond_to do |format|
        format.html { redirect_to @location, notice: "Location was successfully created." }
        format.json { render json: @location, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      respond_to do |format|
        format.html { redirect_to @location, notice: "Location was successfully updated." }
        format.json { render json: @location, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:member_id, :lat, :lng)
    end
end
