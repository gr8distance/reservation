# == Schema Information
#
# Table name: reservations
#
#  id         :integer          not null, primary key
#  amount     :integer          default(1), not null
#  end_at     :datetime         not null
#  start_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_reservations_on_start_at_and_end_at  (start_at,end_at) UNIQUE
#
require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
