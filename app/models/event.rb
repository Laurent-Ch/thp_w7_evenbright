class Event < ApplicationRecord
  belongs_to :host, class_name: "User"
  has_many :attendances
  has_many :guests, class_name: "User", through: :attendances

  validates :start_date,
  presence: true
  validate :is_passed?

  validates :duration,
  presence: true
  validate :duration_specs

  validates :title,
  presence: true,
  length: { in: 5..140 }

  validates :description,
  presence: true,
  length: { in: 20..1000 }

  validates :price, presence: true
  validates_inclusion_of :price, :in => 1..1000

  validates :location,
  presence: true

  def end_date
    self.start_date + self.duration*60
  end

  private

  def is_passed?
    start_date = self.start_date
    unless start_date > DateTime.now
      errors.add(:start_date, "must be before end time")
    end
  end

  def duration_specs
    unless duration > 0 && duration % 5 == 0
      errors.add(:duration, "please select a valid duration")
    end
  end

end