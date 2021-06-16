class BuildingsController < ApplicationController
  before_action :set_building, only: [:show, :update, :destroy, :show_owner]
  

  # GET /buildings
  def index
    @buildings = Building.all

    render json: @buildings
  end

  # GET /buildings/1
  def show
    render json: @building
  end

  def show_owner
    if (@building.agency_id == current_agency.id || @building.id == current_owner.building_id)
      render json: @building, include: [:owners]
    end
  end

  # POST /buildings
  def create
    @building = Building.new(building_params)
    @building.agency_id = current_agency.id if current_agency

    if @building.save
      render json: @building, status: :created, location: @building
    else
      render json: @building.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /buildings/1
  def update
    if @building.agency_id == current_agency.id
      if @building.update(building_params)
        render json: @building
      else
        render json: @building.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /buildings/1
  def destroy
    if @building.agency_id == current_agency.id
      @building = Building.find_by(agency_id: current_agency, id: params[:id])
      @owner = Owner.find_by(building_id: @building.id)
      while @owner != nil
        @owner.destroy
        @owner = Owner.find_by(building_id: @building.id)
      end
      @event = Event.find_by(building_id: @building.id)
      while @event != nil
        @event.destroy
        @event = Event.find_by(building_id: @building.id)
      end
      @building.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def building_params
      params.require(:building).permit(:name, :reference, :city, :adress, :zipcode, :building_image)
    end
end