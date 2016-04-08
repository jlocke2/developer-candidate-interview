class RequestAppointment
  include Interactor::Organizer

  organize JoinAppointment
end