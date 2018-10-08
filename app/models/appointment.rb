class Appointment < ApplicationRecord
  belongs_to :professional
  belongs_to :client

  attr_accessor :initiated_by, :review
  before_validation :set_attributes
  before_save :add_schedule, if: :new_record?
  before_save :update_schedule, unless: :new_record?

  private

  def set_attributes
    self.work_date = start_at.to_date
    self.metadata = {
                      initiated_by: initiated_by,
                      review: review
                    }
  end

  def add_schedule
    schedule = Schedule.create!(professional_id: professional_id, start_at: start_at, end_at: end_at, work_date: work_date)
    self.matching_schedule_id = schedule.id
  end

  def update_schedule
    if self.start_at_changed? || self.end_at_changed?
      unless self.matching_schedule_id.blank?
         Schedule.find(self.matching_schedule_id).tap do |schedule|
           schedule.start_at = self.start_at
           schedule.end_at = self.end_at
           schedule.save!
         end
      end
    end
  end
end
