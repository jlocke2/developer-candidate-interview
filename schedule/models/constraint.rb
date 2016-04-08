class Constraint < ActiveRecord::Base
  belongs_to :trainer

  validates :training_type, presence: true
  validates :max_participants, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_date, presence: true
  validates :end_time, presence: true
  validates :duration, presence: true

  scope :group_lesson, -> {where(training_type: "Group Lesson")}
  scope :private_lesson, -> {where(training_type: "Private Lesson")}

  attr_accessor :name
end