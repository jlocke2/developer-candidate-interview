class RequestsParserCsv
  require 'csv'
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def parse(file)
    csv = CSV.new(open(file), :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])
    csv.to_a.map {|row| row.to_hash }
  end

end