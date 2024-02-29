class ReservableTimesController < ApplicationController
  before_action :set_reservable_time, only: %i[ show edit update destroy ]

  # GET /reservable_times or /reservable_times.json
  def index
    @reservable_times = ReservableTime.all
  end

  # GET /reservable_times/1 or /reservable_times/1.json
  def show
  end

  # GET /reservable_times/new
  def new
    @reservable_time = ReservableTime.new
  end

  # GET /reservable_times/1/edit
  def edit
  end

  # POST /reservable_times or /reservable_times.json
  def create
    @reservable_time = ReservableTime.new(reservable_time_params)

    respond_to do |format|
      if @reservable_time.save
        format.html { redirect_to reservable_time_url(@reservable_time), notice: "Reservable time was successfully created." }
        format.json { render :show, status: :created, location: @reservable_time }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservable_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservable_times/1 or /reservable_times/1.json
  def update
    respond_to do |format|
      if @reservable_time.update(reservable_time_params)
        format.html { redirect_to reservable_time_url(@reservable_time), notice: "Reservable time was successfully updated." }
        format.json { render :show, status: :ok, location: @reservable_time }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservable_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservable_times/1 or /reservable_times/1.json
  def destroy
    @reservable_time.destroy!

    respond_to do |format|
      format.html { redirect_to reservable_times_url, notice: "Reservable time was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservable_time
      @reservable_time = ReservableTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservable_time_params
      params.require(:reservable_time).permit(:minute)
    end
end
