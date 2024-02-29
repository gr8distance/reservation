require 'pry'
require 'active_support/all'

class User
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Reservation
  class ExceedReservers < StandardError; end
  class AlreadyReserved < StandardError; end

  attr_reader :start_at, :end_at, :amount, :canelable, :id, :full_house
  attr_accessor :reservers

  def initialize(start_at:, end_at:, amount: 1, cancelable: true, full_house: false)
    @start_at = start_at
    @end_at = end_at
    @amount = amount
    @canelable = cancelable
    @reservers = []
    @id = gen_id
    @full_house = full_house
  end

  def full_house?
    full_house
  end

  def reserve!(user)
    raise ExceedReservers if reservers.size >= amount
    raise AlreadyReserved if reservers.include?(user)

    reservers << user
  end

  def cancel!(user)
    reservers.delete(user)
  end

  private

  def gen_id
    Digest::SHA256.hexdigest("#{start_at.to_i}-#{end_at.to_i}")
  end
end

# mar = DateTime.parse('2021-03-01')
# business_hour_start = mar + 9.hours
# split_hour = 1.hour
#
# reservables = Array.new(31) do |i|
#   start_at = business_hour_start + i.days
#   Array
#     .new(8) { |j| start_at + j.hour }
#     .map { |s| Reservation.new(start_at: s, end_at: s + split_hour, amount: 3) }
# end.flatten

# SPEC:
# 1. 予約可能な時間は原則として設定者が決定できる(デフォルトは1時間単位)
# 2. 予約可能な時間は営業時間内のみ。今回は(9:00-17:00)
# 3. 特別ルールで臨時休業なども設定可能
# 4. 実際に予約が入った場合は、予約可能最大数に応じてその枠を欠番とする

# reservable = reservables.sample
# reservable.reserve!(user)
# reservable.cancel!(user)

class BusinessHour
  attr_reader :start_at, :end_at
  def initialize(start_at, end_at)
    @start_at = start_at
    @end_at = end_at
  end
end

class ReservableTime
  attr_reader :minute
  def initialize(minute)
    @minute = minute
  end
end

class Holiday
  attr_reader :date
  def initialize(date)
    @date = date
  end
end

class BusinessCaledar
  attr_reader :business_hours, :reservable_times, :holidays, :reserved

  def initialize(business_hours, reservable_times, holidays, reserved: [])
    @business_hours = business_hours
    @reservable_times = reservable_times
    @holidays = holidays
    @reserved = reserved
  end

  def build(from, to)
    build_business_range(from, to).flat_map do |date|
      start_at = date + business_hours.start_at
      end_at = date + business_hours.end_at
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

user = User.new('user')
business_hours = BusinessHour.new(9.hours, 17.hours)
reservable_times = ReservableTime.new(60.minutes)
holidays = [
  Holiday.new(Date.parse('2024-03-01')),
  Holiday.new(Date.parse('2024-03-04'))
]
calendar = BusinessCaledar.new(business_hours, reservable_times, holidays)
reservables = calendar.build(
  Date.parse('2024-03-01'),
  Date.parse('2024-03-07')
)

reservation = reservables[10]
reservation.reserve!(user)
new_calendar = BusinessCaledar.new(business_hours, reservable_times, holidays, reserved: [reservation])
new_reservables = new_calendar.build(
  Date.parse('2024-03-01'),
  Date.parse('2024-03-07')
)

binding.pry
