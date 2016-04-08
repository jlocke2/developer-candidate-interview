class Constraint < ActiveRecord::Base
  belongs_to :trainer

  validates :training_type, presence: true
  validates :max_participants, presence: true
  validates :start_date, presence: true
  validates :start_time, presence: true
  validates :end_date, presence: true
  validates :end_time, presence: true
  validates :duration, presence: true

  attr_accessor :name
end