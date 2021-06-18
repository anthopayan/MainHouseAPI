class AgenciesController < ApplicationController
  before_action :set_agency, only: [:show, :update, :show_owner, :show_event, :show_building, :destroy]

  # GET /agencies
  def index
    @agencies = Agency.all

    render json: @agencies
  end

  # GET /agencies/1
  def show
      render json: @agency
  end

  def show_building
    render json: @agency, include: [:buildings]
  end

  def show_owner
    if @agency.id == current_agency.id
      render json: @agency, include: [:owners]
    end
  end

  def show_event
    if @agency.id == current_agency.id
      render json: @agency, include: [:events]
    end
  end

  # POST /agencies
  def create
    @agency = Agency.new(agency_params)

    if @agency.save
      render json: @agency, status: :created, location: @agency
    else
      render json: @agency.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /agencies/1
  def update
    if @agency.id == current_agency.id
      if @agency.update(agency_params)
        render json: @agency
      else
        render json: @agency.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /agencies/1
  def destroy
    @agency.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agency
      @agency = Agency.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def agency_params
      params.require(:agency).permit(:name, :city, :adress, :zipcode, :phone_number, :logo_agency_url, :siren)
    end
end