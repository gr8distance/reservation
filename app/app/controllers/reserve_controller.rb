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
  end
end
