class AppointmentsController
  # This is our "Controller" in MVC
  # will receive the input
  # pass processing to the "Model"
  # and send appropriate ouput to the "View" (conflict_outputter_console.rb)

  # A little Dependency Injection, so we can mix things up without having to modify this class
  # this relates to Open/Closed Principle in SOLID, I believe
  def initialize(opts = {})
    @parsers = opts[:parsers] || {csv: RequestsParserCsv.new}
    @output = opts[:output] || RequestOutputConsole.new
  end

  # Pseudo RESTful Route
  # We could expand this to include the others

  def create(file)
    # A guard clause checking for matching file types
    filetype = File.extname(file.to_s).delete('.').to_sym
    return "Sorry! We can only handle the following file types: #{@parsers.keys.join}. Please try again!" unless @parsers.keys.include? filetype

    requests = @parsers[filetype].parse(file)
    
    requests.each do |request|
      result = RequestAppointment.call(request)

      if result.success?
        @output.print_success_message
      else
        @output.print_failure_message(result.request_id, result.error_messages)
      end
      
    end
  end


end