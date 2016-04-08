class JoinAppointment
  include Interactor

  before :create_error_array, :find_student, :find_trainer

  def call
    appointment = context.student.appointments.build(start_date: context.start_date, end_date: context.end_date, start_time: context.start_time, end_time: context.end_time, training_type: context.training_type, trainer_id: context.trainer.id, request_id: context.request_id)

    if appointment.save
      context.appointment = appointment
    else
      context.error_messages << appointment.errors.messages
      context.fail!
    end
  end

  def create_error_array
    context.error_messages = []
  end

  def find_student
    context.student = Student.find_or_create_by(name: context.name)
  end

  def find_trainer
    context.trainer = Trainer.find_by(base_name: context.with.convert_to_basename)
    unless context.trainer
      context.error_messages << {:base=>["instructor not available"]}
      context.fail!
    end
  end

end