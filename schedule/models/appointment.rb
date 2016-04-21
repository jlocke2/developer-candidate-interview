class Appointment < ActiveRecord::Base
  # http://martinfowler.com/apsupp/recurring.pdf
  # http://stackoverflow.com/questions/1643875/how-to-use-activerecord-in-a-ruby-script-outside-rails
  belongs_to :trainer
  belongs_to :student

  ## here's our objective order
  # 1. trainer exists? # :trainer_exists validation
  # 2. trainer constraint no conflict # :not_too_long validation
  # 3. student no schedule conflict # :student_available validation
  # 4. trainer no private conflict # :no_private_session_conflict_for_trainer validation
  # 5. trainer only perfect match for group # :exact_match_for_group_session validation
  # 6. group session not full # :session_capacity validation
  ## if all these pass we create the appointment

  before_validation :set_trainer, :set_student

  validate :trainer_exists
  validate :during_trainer_availability
  validate :not_too_long, if: proc {|apt| apt.training_type == "Group Lesson"}
  validate :student_available
  validate :no_private_session_conflict_for_trainer, if: proc {|apt| apt.training_type == "Private Lesson"}
  validate :exact_match_for_group_session, if: proc {|apt| apt.training_type == "Group Lesson"}
  validate :session_capacity, if: proc {|apt| apt.training_type == "Group Lesson"}

  validates :student, presence: true
  validates :trainer, presence: true
  validates :request_id, presence: true, numericality: true
  validates :training_type, presence: true, inclusion: { in: ['Private Lesson', 'Group Lesson']}
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :date_overlap, -> (start_date, end_date) {where("(start_date >= :start_date AND start_date <= :end_date) OR (start_date <= :start_date AND end_date >= :start_date)", start_date: start_date, end_date: end_date)}
  scope :time_exact, -> (start_time, end_time) {where("(start_time = :start_time AND end_time = :end_time)", start_time: start_time, end_time: end_time)}
  scope :time_exact_or_overlap, -> (start_time, end_time) {where("(start_time >= :start_time AND start_time <= :end_time) OR (start_time <= :start_time AND end_time >= :start_time)", start_time: start_time, end_time: end_time)}

  attr_accessor :with, :name

  private

  def set_trainer
    @trainer = Trainer.find(trainer_id) if trainer_id
  end

  def set_student
    @student = Student.find(student_id) if student_id
  end

  def trainer_exists
    unless @trainer
      errors[:base] << "instructor not available"
    end
  end

  def during_trainer_availability
    constraint = @trainer && @trainer.constraints.where(training_type: training_type).first
    if constraint
      unless constraint.start_date <= start_date && constraint.end_date >= end_date &&
             constraint.start_time <= start_time && constraint.end_time >= end_time
        errors[:base] << "instructor not available"
      end
    end
  end

  def not_too_long
    if @trainer
      constraint = @trainer.constraints.group_lesson.first
      if constraint && (Time.parse(end_time) - Time.parse(start_time)) > (constraint.duration.split.first.to_i * 3600)
        errors[:base] << "instructor not available"
      end
    end
  end

  def student_available
    if @student && @student.appointments.date_overlap(start_date,end_date).time_exact_or_overlap(start_time,end_time).any?
      errors[:base] << "student not available"
    end
  end

  def no_private_session_conflict_for_trainer
    if @trainer && @trainer.appointments.date_overlap(start_date,end_date).time_exact_or_overlap(start_time,end_time).any?
      errors[:base] << "instructor not available"
    end
  end

  def exact_match_for_group_session
    if @trainer
      appointments = @trainer.appointments.date_overlap(start_date,end_date).time_exact_or_overlap(start_time,end_time)
      if appointments.any? && appointments.time_exact(start_time,end_time).empty?
        errors[:base] << "instructor not available"
      end
    end
  end

  def session_capacity
    if @trainer
      appointments = @trainer.appointments.date_overlap(start_date,end_date).time_exact(start_time,end_time)
      constraint = @trainer.constraints.group_lesson.first
      if constraint && appointments.count >= constraint.max_participants.to_i
        errors[:base] << "instructor not available"
      end
    end
  end

end