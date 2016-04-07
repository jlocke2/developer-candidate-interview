=begin

Hey Jason!

Start reading here

=end
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'runt'
require 'interactor'

# Connect to an in-memory sqlite3 database
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define a minimal database schema
ActiveRecord::Schema.define do
  create_table :students, force: true do |t|
    t.string :name
    t.string :base_name
  end

  create_table :trainers, force: true do |t|
    t.string :name
    t.string :base_name
  end

  create_table :appointments, force: true do |t|
    t.integer :request_id
    t.belongs_to :student, index: true
    t.belongs_to :session, index: true
  end

  create_table :sessions, force: true do |t|
    t.string :training_type
    t.date :date
    t.string :start_time
    t.string :end_time

    t.belongs_to :trainer, index: true
  end

  create_table :constraints, force: true do |t|
    t.string :training_type
    t.string :max_participants
    t.date :start_date
    t.string :start_time
    t.date :end_date
    t.string :end_time
    t.string :duration

    t.belongs_to :trainer, index: true
  end

end


require_relative './models/appointment.rb'
require_relative './models/constraint.rb'
require_relative './models/session.rb'
require_relative './models/student.rb'
require_relative './models/trainer.rb'


require_relative './controllers/appointments_controller.rb'
require_relative './controllers/constraints_controller.rb'

require_relative './views/request_output_console.rb'

require_relative './interactors/establish_session.rb'
require_relative './interactors/join_session.rb'
require_relative './interactors/request_appointment.rb'

require_relative './lib/extend_string.rb'
require_relative './lib/requests_parser_csv.rb'

constraint_builder = ConstraintsController.new
constraint_builder.create("instructor_availability.csv")

schedule_builder = AppointmentsController.new
schedule_builder.create("input.csv")