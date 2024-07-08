class FamilyMembersController < ApplicationController
  before_action :set_family_member, only: %i[ show edit update destroy ]

  # GET /family_members
  def index
    @family_members = FamilyMember.all
  end

  # GET /family_members/1
  def show
    @family_member = FamilyMember.find(params[:id])
  end

  # GET /family_members/new
  def new
    @family_member = FamilyMember.new
  end

  # GET /family_members/1/edit
  def edit
  end

  # POST /family_members
  def create
    @family_member = FamilyMember.new(family_member_params)

    if @family_member.save
      redirect_to @family_member, notice: "Family member was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /family_members/1
  def update
    if @family_member.update(family_member_params)
      redirect_to @family_member, notice: "Family member was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /family_members/1
  def destroy
    @family_member.destroy!
    redirect_to family_members_url, notice: "Family member was successfully destroyed.", status: :see_other
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
