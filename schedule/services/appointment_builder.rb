class AppointmentBuilder

  def initialize(request = {})
    @request = request
    @student = Student.find_or_create_by(name: @request[:name])
    @trainer = Trainer.find_or_create_by(base_name: @request[:with].gsub(/[^a-z\s\_]/i, '').split.join(" ").downcase.gsub(/\s+/,"_"))
  end

  def add
    appointment = Appointment.where("start_date = ? AND end_date = ? AND start_time = ? AND end_time = ?", @request[:start_date], @request[:end_date], @request[:start_time], @request[:end_time]).first_or_initialize

    if appointment.new_record?
      puts "new"
      appointment = Appointment.new(@request)
      appointment.trainer_id = @trainer.id
    else
      puts "not new"
      appointment.student_appointments.build(student_id: @student.id)
    end
    appointment.save
    appointment
  end
      
end