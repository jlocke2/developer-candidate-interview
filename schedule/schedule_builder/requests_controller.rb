class RequestsController
  # This is essentially our "Controller" in MVC
  # will receive the input
  # pass processing to the "Model" (conflict_tester.rb)
  # and send appropriate ouput to the "View" (conflict_outputter_console.rb)

  # A little Dependency Injection, so we can mix things up without having to modify this class
  # this relates to Open/Closed Principle in SOLID, I believe
  def initialize(opts)
    @parsers = opts[:parsers] || {csv: RequestsParserCsv.new}
    @conflict_tester = opts[:conflict_tester] || RequestModel.new
    @output = opts[:output] || RequestOutputConsole.new
    @datastore = opts[:datastore] || DataStoreLocal.new
  end

  # Pseudo RESTful Route
  # We could expand this to include the others

  def create(file)
    # A guard clause checking for matching file types
    filetype = File.extname(input.to_s).delete('.').to_sym
    return "Sorry! We can only handle the following file types: #{@parsers.keys.join}. Please try again!" unless @parsers.keys.include? filetype

    requests = @parser[filetype].parse(file)

    requests.each do |request|
      request = @conflict_tester.save(request)
      @output.display_message(request)
    end

  end


end