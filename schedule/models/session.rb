class Session < ActiveRecord::Base
  belongs_to :trainer

  has_many :appointments
  has_many :students, through: :appointments

  validate :trainer_available, if: proc {|ses| ses.training_type == "Private Lesson"}
  validate :session_capacity, if: proc {|ses| ses.training_type == "Group Lesson"}

  validates :training_type, presence: true, inclusion: { in: ['Private Lesson', 'Group Lesson']}
  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :trainer_id, presence: true, numericality: true

  private

  def trainer_available
    trainer = Trainer.find(trainer_id)
    if trainer.sessions.where(date: date, start_time: start_time, end_time: end_time).any?
      errors[:base] << "instructor not available"
    end
  end

  def session_capacity
    trainer = Trainer.find(trainer_id)
    if trainer.constraints.any?
      if self.students.count >= trainer.constraints.where(training_type: "Group Lesson").first.max_participants.to_i
        errors[:base] << "instructor not available"
      end
    end
  end
  
end