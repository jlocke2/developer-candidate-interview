class ConstraintsController
  # This is our "Controller" in MVC
  # will receive the input
  # pass processing to the "Model"
  # and send appropriate ouput to the "View" (conflict_outputter_console.rb)

  # A little Dependency Injection, so we can mix things up without having to modify this class
  # this relates to Open/Closed Principle in SOLID, I believe
  def initialize(opts = {})
    @parsers = opts[:parsers] || {csv: RequestsParserCsv.new}
  end

  # Pseudo RESTful Route
  # We could expand this to include the others

  def create(file)
    # A guard clause checking for matching file types
    filetype = File.extname(file.to_s).delete('.').to_sym
    return "Sorry! We can only handle the following file types: #{@parsers.keys.join}. Please try again!" unless @parsers.keys.include? filetype

    constraints = @parsers[filetype].parse(file)
    
    constraints.each do |constraint|
      trainer = Trainer.find_or_create_by(name: constraint[:name])
      trainer.constraints.build(constraint).save
    end

  end


end