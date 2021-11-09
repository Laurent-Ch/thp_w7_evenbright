class Attendance < ApplicationRecord
  after_create :warning_host

  belongs_to :guest, class_name: "User"
  belongs_to :event

  validates :stripe_customer_id,
  presence: true,
  uniqueness: true

  def warning_host
    AttendanceMailer.warning_email(self).deliver_now
  end

end
