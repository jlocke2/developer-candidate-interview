require 'rspec'
require_relative '../../lib/requests_parser_csv'

describe RequestsParserCsv do

  describe "#parse" do
    before :each do
      @csv_file = 'input.csv'
      @result = RequestsParserCsv.new.parse(@csv_file)
    end

    it "takes a CSV file and returns array of hashes with CSV headers as hash keys" do
      csv_headers = CSV.read(@csv_file, {headers: true, header_converters: :symbol}).headers

      expect(@result).to all(include(*csv_headers))
    end

    it "produces array with hash for each row of CSV minus header row" do
      num_of_row = CSV.read(@csv_file, {headers: true}).length

      expect(@result.length).to eq num_of_row
    end
  end

end