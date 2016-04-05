require_relative './schedule_builder/requests_controller.rb'
require_relative './schedule_builder/requests_parser_csv.rb'
require_relative './schedule_builder/request_model.rb'
require_relative './schedule_builder/request_output_console.rb'


schedule_builder = RequestsController.new
schedule_builder.create("input.csv")