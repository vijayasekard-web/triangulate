class Schedule < ApplicationRecord
  belongs_to :professional

  #before_validation :set_work_date

  private

  def set_work_date
    self.work_date = Date.parse start_at
  end
end
