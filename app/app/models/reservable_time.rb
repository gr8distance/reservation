# == Schema Information
#
# Table name: reservable_times
#
#  id         :integer          not null, primary key
#  minute     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ReservableTime < ApplicationRecord
end
