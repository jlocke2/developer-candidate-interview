class RequestModel
  # this is essentially our "Model" in MVC
  require "yaml/store"

  def initialize(opts = {})
    @datastore = opts[:datastore] || YAML::Store.new("data_store_local.yml")
    @validations = opts[:validations] || [:student_available, :instructor_available]
  end

  def save(request)
    request[:errors] = []
    request = validate(request)

    if request[:errors].empty?
      @datastore.transaction do
        @datastore[:appointments] = [] unless @datastore[:appointments]
        @datastore[:appointments].push(request)
        puts @datastore[:appointments].count
      end
    end

    request
  end

  private

  def validate(request)
    @validations.each{|validation| RequestModel.send(validation, request)} if @validations.any?

    request
  end

  def self.student_available(request)
    request
  end

  def self.instructor_available(request)
    request
  end

end