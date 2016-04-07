class JoinSession
  include Interactor

  before :find_student

  def call
    appointment = context.session.appointments.build({request_id: context.request_id, session_id: context.session.id, student_id: context.student.id}) #FINISH

    if appointment.save
      context.appointment = appointment
    else
      context.error_messages << appointment.errors.messages
      context.fail!
    end
  end

  def find_student
    context.student = Student.find_or_create_by(name: context.name)
  end

end