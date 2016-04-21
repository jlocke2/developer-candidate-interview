class JoinAppointment
  include Interactor

  before :find_student, :find_trainer

  def call
    appointment = Appointment.new(start_date: context.start_date, end_date: context.end_date, 
                  start_time: context.start_time, end_time: context.end_time, training_type: context.training_type, 
                  trainer_id: context.trainer.try(:id), request_id: context.request_id, student_id: context.student.id)

    context.appointment = appointment

    unless appointment.save
      context.fail!
    end
  end

  def find_student
    context.student = Student.find_or_create_by(name: context.name)
  end

  def find_trainer
    context.trainer = Trainer.find_by(base_name: context.with.convert_to_basename)
  end

end