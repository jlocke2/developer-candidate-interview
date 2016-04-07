class Appointment < ActiveRecord::Base
  include Runt
  # http://martinfowler.com/apsupp/recurring.pdf
  # https://github.com/mlipper/runt
  # http://stackoverflow.com/questions/1643875/how-to-use-activerecord-in-a-ruby-script-outside-rails
  belongs_to :trainer

  has_many :student_appointments
  has_many :students, through: :student_appointments

  validate :student_available, on: :create
  validate :trainer_available, if: proc {|apt| apt.training_type == "Private Lesson"}
  validate :session_capacity, if: proc {|apt| apt.training_type == "Group Lesson"}

  attr_accessor :with, :name


  private

  def student_available
    puts "#{self.inspect} something"
    puts Trainer.all.map(&:base_name)
    student = Student.find_by(base_name: name.gsub(/[^a-z\s\_]/i, '').split.join(" ").downcase.gsub(/\s+/,"_"))
    student.appointments.each do |apt|
      if false
        errors[:base] << "student not available"
        return
      end
    end
  end

  def trainer_available
    trainer = Trainer.find(trainer_id)
    trainer.appointments.each do |apt|
      if false
        errors[:base] << "instructor not available"
        return
      end
    end
  end

  def session_capacity
    trainer = Trainer.find(trainer_id)
    puts self.students.count
    max_persons = trainer.availabilities.where(training_type: "Group Lesson").first.max_participants.to_i
    puts max_persons
    if self.students.count >= max_persons
      errors[:base] << "instructor not available"
    end
  end

end