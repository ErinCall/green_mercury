class VolunteerBlock < ActiveRecord::Base
  belongs_to :user
  validates :hours, numericality: {greater_than: 0}
  validates :on, presence: true
end
