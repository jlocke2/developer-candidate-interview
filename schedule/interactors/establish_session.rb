class EstablishSession
  include Interactor

  before :find_trainer, :create_error_array

  def call
    session = context.trainer.sessions.where(date: context.start_date, start_time: context.start_time, end_time: context.end_time).first_or_initialize

    session.training_type ||= context.training_type

    if session.training_type == "Private Lesson"
      context.error_messages << {:base=>["student not available"]}
      context.fail! unless session.new_record?
    end

    if session.save
      context.session = session
    end

  end

  def rollback
    context.session.destroy if context.session.students.count == 0
  end

  def find_trainer
    context.trainer = Trainer.find_or_create_by(base_name: context.with.convert_to_basename)
  end

  def create_error_array
    context.error_messages = []
    context.appointments = []
  end
end