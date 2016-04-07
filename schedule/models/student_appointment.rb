class StudentAppointment < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :student

  validate :student_available

  private

  def student_available
    student = Student.find(student_id)
    student.appointments.each do |apt|
      if false
        errors[:base] << "student not available"
        return
      end
    end
  end


end