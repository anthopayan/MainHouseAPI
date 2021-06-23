class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :update, :destroy]

  # GET /owners
  def index
    @owners = Owner.all

    render json: @owners
  end

  # GET /owners/1
  def show
      render json: @owner
  end

  # POST /owners
  def create
    @owner = Owner.new(owner_params)

    if @owner.save
      render json: @owner, status: :created, location: @owner
    else
      render json: @owner.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /owners/1
  def update
    if @owner.id == current_owner.id
      if @owner.update(owner_params)
        render json: @owner
      else
        render json: @owner.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /owners/1
  def destroy
    @owner.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_owner
      @owner = Owner.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def owner_params
      params.require(:owner).permit(:agency_id, :building_id, :first_name, :last_name, :phone_number, :lot, :flat_number, :owner_pic_profil)
    end
end