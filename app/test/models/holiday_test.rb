# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_holidays_on_date  (date) UNIQUE
#
require "test_helper"

class HolidayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
