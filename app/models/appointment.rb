class Appointment < ApplicationRecord
  belongs_to :professional
  belongs_to :client

  include SchedulesHelper

  attr_accessor :initiated_by, :review
  before_validation :set_attributes
  validate :if_schedule_available?
  before_save :add_schedule, if: :new_record?
  before_save :update_schedule, unless: :new_record?
  after_commit :update_matching_appointment_id, on: :create

  APPOINTMENT_STATUS = { pending: 0, confirmed: 1, cancelled: 2 }

  private

  def set_attributes
    self.work_date = start_at.to_date
    self.metadata = {
                      initiated_by: initiated_by,
                      review: review
                    }
  end

  def if_schedule_available?
    schedules = Schedule.where(professional_id: professional_id, work_date: "2018-10-18").where.not("start_at >= ? OR end_at <= ?", end_at, start_at)
    if schedules.count > 0
      self.errors.add :start_at, 'no schedule available'
      self.errors.add :end_at, 'no schedule available'
    end
  end

  def add_schedule
    schedule = Schedule.create!(professional_id: professional_id, start_at: start_at, end_at: end_at, work_date: work_date)
    self.matching_schedule_id = schedule.id
  end

  def update_schedule
    if self.status == APPOINTMENT_STATUS[:cancelled]
      Schedule.find(self.matching_schedule_id).destroy!
    else
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

  def update_matching_appointment_id
    Schedule.find(self.matching_schedule_id).tap do |schedule|
           schedule.matching_appointment_id = self.id
           schedule.description = "You are meeting someone at this time"
           schedule.save!
     end
  end
end
