class RequestOutputConsole
  # this is essentially our "View" in MVC

  def display_message(request)
    if request.errors.messages.empty?
      print_success_message(request)
    else
      print_failure_message(request)
    end
  end

  private

  def print_success_message(request)
    success_message = <<-HEREDOC

    Appointment successfully created!

    HEREDOC

    $stdout.puts success_message
  end

  def print_failure_message(request)
    failure_message = <<-HEREDOC

    Request ID: #{request.request_id}
    Reason for Conflict: #{request.errors.messages[:base].join(', ')}

    HEREDOC

    $stdout.puts failure_message
  end

end