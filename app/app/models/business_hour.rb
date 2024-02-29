# == Schema Information
#
# Table name: business_hours
#
#  id         :integer          not null, primary key
#  end_at     :integer          not null
#  start_at   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_business_hours_on_start_at_and_end_at  (start_at,end_at) UNIQUE
#
class BusinessHour < ApplicationRecord
end
