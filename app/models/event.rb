# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :host, class_name: 'User'
  has_many :attendances
  has_many :guests, class_name: 'User', through: :attendances

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
  validates_inclusion_of :price, in: 1..1000

  validates :location,
            presence: true

  def end_date
    start_date + duration * 60
  end

  private

  def is_passed?
    start_date = self.start_date
    errors.add(:start_date, 'must be before end time') unless start_date > DateTime.now
  end

  def duration_specs
    errors.add(:duration, 'please select a valid duration') unless duration.positive? && (duration % 5).zero?
  end
end
