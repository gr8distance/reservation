require 'pry'
require 'active_support/all'

class User
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Reservation
  attr_reader :start_at, :end_at, :reserver
  def initialize(start_at:, end_at:, reserver:)
    @start_at = start_at
    @end_at = end_at
    @reserver = reserver
  end
end

class ReservableSlot
  class ExceedReservers < StandardError; end
  class AlreadyReserved < StandardError; end

  attr_reader :start_at, :end_at, :amount, :canelable
  attr_accessor :reservers

  def initialize(start_at:, end_at:, amount: 1, cancelable: true)
    @start_at = start_at
    @end_at = end_at
    @amount = amount
    @canelable = cancelable
    @reservers = []
  end

  def reserve!(user)
    raise ExceedReservers if reservers.size >= amount
    raise AlreadyReserved if reservers.include?(user)

    reservers << user
  end

  def cancel!(user)
    reservers.delete(user)
  end
end

mar = DateTime.parse('2021-03-01')
business_hour_start = mar + 9.hours
split_hour = 1.hour

reservables = Array.new(31) do |i|
  start_at = business_hour_start + i.days
  Array
    .new(8) { |j| start_at + j.hour }
    .map { |s| ReservableSlot.new(start_at: s, end_at: s + split_hour, amount: 3) }
end.flatten

user = User.new('user')
reservable = reservables.sample
binding.pry
