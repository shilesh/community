class FamilyMembersController < ApplicationController
  before_action :set_family_member, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /family_members
  def index
    @family_members = FamilyMember.all

    respond_to do |format|
      format.html 
      format.json  {render json: @family_members.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # GET /family_members/1
  def show
    @family_member = FamilyMember.find(params[:id])

    respond_to do |format|
      format.html 
      format.json  {render json: @family_member.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # GET /family_members/new
  def new
    @family_member = FamilyMember.new
  end

  # GET /family_members/1/edit
  def edit
    respond_to do |format|
      format.html 
      format.json  {render json: @family_member.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # POST /family_members
  def create
    @family_member = FamilyMember.new(family_member_params)

    respond_to do |format|
      if @family_member.save
        format.html {redirect_to @family_member, notice: "Family member was successfully created."}
        format.json  {render json: @family_member} 
      else
        format.html {render action: "new", status: :unprocessable_entity}
        format.json  {render json:@family_member.errors, status: :unprocessable_entity}
      end
    end 
  end

  # PATCH/PUT /family_members/1
  def update

    respond_to do |format|
      if @family_member.update(family_member_params)
        format.html {redirect_to @family_member, notice: "Family member was successfully updated.", status: :see_other}
        format.json  {render json: @family_member.as_json(only: [:id, :name, :mobile, :blood_group])} 
      else
        format.html {render action: "edit", status: :unprocessable_entity}
        format.json  {render json:@family_member.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /family_members/1
  def destroy
    respond_to do |format|
      @family_member.destroy!
      format.html {redirect_to family_members_url, notice: "Family member was successfully destroyed.", status: :see_other}
      format.json  {render json: {message: "Family member was successfully destroyed"}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family_member
      @family_member = FamilyMember.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def family_member_params
      params.fetch(:family_member, {}).permit(:name, :mobile, :blood_group)
    end
end
