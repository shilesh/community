class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  
  # GET /members
  def index
    @members = Member.all
    # render json: @members, only: [:id ,:name, :mobile, :blood_group]

    respond_to do |format|
      format.html 
      format.json  {render json: @members.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # GET /members/1
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html 
      format.json  {render json: @member.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
    respond_to do |format|
      format.html 
      format.json  {render json: @member.as_json(only: [:id, :name, :mobile, :blood_group])}
    end
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html {redirect_to @member, notice: "Member was successfully created." }
        format.json  {render json: @member.as_json(only: [:id, :name, :mobile, :blood_group])} 
      else
        format.html {render action: "new", status: :unprocessable_entity}
        format.json  {render json: @member.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /members/1
  def update

    respond_to do |format|
      if @member.update(member_params)
        format.html {redirect_to @member, notice: "Member was successfully updated.", status: :see_other}
        format.json  {render json: @member.as_json(only: [:id, :name, :mobile, :blood_group])} 
      else
        format.html {render action: "edit", status: :unprocessable_entity}
        format.json  {render json:@member.errors, status: :unprocessable_entity}
      end
    end  
  end

  # DELETE /members/1
  def destroy
    respond_to do |format|
      if @member.destroy!
        format.html {redirect_to members_url, notice: "Member was successfully destroyed.", status: :see_other}
        format.json  {render json: {message: "Member was successfully destroyed"}}
      end 
    end 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.fetch(:member, {}).permit(:name, :mobile, :blood_group)
    end
end
