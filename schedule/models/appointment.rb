class Appointment < ActiveRecord::Base
  # http://martinfowler.com/apsupp/recurring.pdf
  # http://stackoverflow.com/questions/1643875/how-to-use-activerecord-in-a-ruby-script-outside-rails
  belongs_to :session
  belongs_to :student

  validate :student_available

  validates :student_id, presence: true, numericality: true
  validates :request_id, presence: true, numericality: true
  validates :session_id, presence: true, numericality: true

  attr_accessor :with, :name


  private

  def student_available
    session = Session.find(session_id)
    student = Student.find(student_id)
    if student.sessions.where(date: session.date, start_time: session.start_time, end_time: session.end_time).any?
      errors[:base] << "student not available"
    end
  end

  def session_capacity
    trainer = Trainer.find(trainer_id)
    if trainer.availabilities.any?
      max_persons = trainer.availabilities.where(training_type: "Group Lesson").first.max_participants.to_i
      if self.students.count >= max_persons
        errors[:base] << "instructor not available"
      end
    end
  end

end