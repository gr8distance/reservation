# == Schema Information
#
# Table name: user_reservations
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reservation_id :integer          not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_user_reservations_on_reservation_id              (reservation_id)
#  index_user_reservations_on_user_id                     (user_id)
#  index_user_reservations_on_user_id_and_reservation_id  (user_id,reservation_id) UNIQUE
#
# Foreign Keys
#
#  reservation_id  (reservation_id => reservations.id)
#  user_id         (user_id => users.id)
#
class UserReservation < ApplicationRecord
  belongs_to :user
  belongs_to :reservation
end
