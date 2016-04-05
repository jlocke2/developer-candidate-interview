class RequestModel
  # this is essentially our "Model" in MVC

  def initialize(opts)
    @datastore = opts[:datastore] || DataStoreLocal.new
    @validations = opts[:validations] || []
  end

  def save(request)
    validate(request)

    @datastore.save(request) if request[:errors].empty?

    request
  end

  private

  def validate(request)
    @validations.each{|validation| validation.call(request)} if @validations.any?

    request
  end

end