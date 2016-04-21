class RequestOutputConsole
  # this is our "View" in MVC

  def print_success_message
    success_message = <<-HEREDOC

    Appointment successfully created!

    HEREDOC

    $stdout.puts success_message
  end

  def print_failure_message(request_id, errors)
    failure_message = <<-HEREDOC

    Request ID: #{request_id}
    Reason for Conflict: #{errors[:base].uniq.join(', ')}

    HEREDOC

    $stdout.puts failure_message
  end

end