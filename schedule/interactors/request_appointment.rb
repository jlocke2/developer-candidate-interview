class RequestAppointment
  include Interactor::Organizer

  organize EstablishSession, JoinSession
end