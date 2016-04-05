class RequestOutputConsole
  # this is essentially our "View" in MVC

  def display_message(request)
    if request[:errors].any?
      print_success_message(request)
    else
      print_failure_message(request)
    end
  end

  private

  def print_success_message(request)
    $stdout.puts "\n Appointment successfully created! \n"
  end

  def print_failure_message(request)
    expected_result <<-HEREDOC

    Student Name: ...
    Attempted Instructor: ...
    Attempted Schedule: ...
    Reason for Conflict: #{request[:errors].join(', ')}

    HEREDOC
  end

end