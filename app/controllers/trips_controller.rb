class TripsController < ApplicationController
  before_action :set_trip, only: %i[ show edit update destroy remove_museum_from_trip add_museum_to_trip]

  # GET /trips or /trips.json
  def index
    @trips = current_user.trips.order("id desc")
    if params[:tp] == "multi_day_trip"
      @trips = @trips.multi_day_trip
    else
      @trips = @trips.day_trip
    end
  end

  # GET /trips/1 or /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    @museums = Museum.paginate(page: params[:page], per_page: 20)
    if params[:filter].present?
      like = "%#{params[:filter]}%"
      @museums = @museums.where(["city like ? or name like ? or description like ?", like, like, like])
    end
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips or /trips.json
  def create
    @trip = current_user.trips.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to action: "index", notice: "Trip was successfully created." }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1 or /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to trip_url(@trip), notice: "Trip was successfully updated." }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1 or /trips/1.json
  def destroy
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url, notice: "Trip was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_museum_from_trip
    museum = Museum.find(params[:museum_id])
    @trip.museums.delete(museum)
    redirect_to trip_url(@trip), notice: "Delete museum from trip sucessfully"
  end

  def add_museum_to_trip
    for id in params[:trip][:museum_ids]
      @trip.museums << Museum.find(id)
    end
    redirect_to trip_url(@trip), notice: "Trip was successfully updated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = current_user.trips.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.require(:trip).permit(:name, :trip_day, museum_ids: [])
    end
end
