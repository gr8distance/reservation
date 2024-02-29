class Cal
  attr_reader :business_hours, :reservable_times, :holidays, :reserved

  def initialize(business_hours, reservable_times, holidays, reserved: [])
    @business_hours = business_hours
    @reservable_times = reservable_times
    @holidays = holidays
    @reserved = reserved
  end

  def build(from, to)
    build_business_range(from, to).flat_map do |date|
      start_at = date + business_hours.start_at.hour
      end_at = date + business_hours.end_at.hour
      build_reservations(start_at, end_at)
    end
  end

  private

  def build_reservations(start_at, end_at)
    Array.new((end_at - start_at) / reservable_times.minute) do |i|
      s = start_at + (reservable_times.minute * i)
      e = start_at + (reservable_times.minute * (i + 1))
      build_reservation(s, e)
    end
  end

  def build_reservation(start_at, end_at, amount = 3)
    # TODO: SQL頑張る💪
    reservation = reserved.find { |r| r.start_at == start_at && r.end_at == end_at }
    case
    when reservation.nil?
      Reservation.new(start_at: start_at, end_at: end_at, amount: amount)
    when reservation.full_house?
      Reservation.new(start_at: start_at, end_at: end_at, amount: amount, full_house: true)
    else
      reservation
    end
  end

  def build_business_range(from, to)
    range = (from..to).to_a
    range - holidays.map(&:date)
  end
end
