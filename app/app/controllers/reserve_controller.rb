class ReserveController < ApplicationController
  def new
    business_hours = BusinessHour.first
    reservable_times = ReservableTime.first.minute
    holidays = Holiday.all
    business_calendar = ::Cal.new(business_hours, reservable_times, holidays)
    @reservables = business_calendar.build(
      Date.parse('2024-03-01'),
      Date.parse('2024-03-07')
    )
    @user = User.first
  end

  def create
    reservation = Reservation.new(
      start_at: params[:start_at],
      end_at: params[:end_at],
      amount: 3
    )
    reservation.save!
    reservation.users << User.find(params[:user_id])
    redirect_to reserve_new_path, notice: '予約完了'
  rescue => e
    redirect_to reserve_new_path, notice: '失敗'
  end

  private
end
