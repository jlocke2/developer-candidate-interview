=begin

Hey Jason!

Start reading here

=end
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'runt'

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

  create_table :availabilities, force: true do |t|
    t.string :training_type
    t.string :max_participants
    t.date :start_date
    t.string :start_time
    t.date :end_date
    t.string :end_time
    t.string :duration

    t.belongs_to :trainer, index: true
  end

  create_table :student_appointments, force: true do |t|
    t.belongs_to :student, index: true
    t.belongs_to :appointment, index: true
  end

  create_table :appointments, force: true do |t|
    t.string :training_type
    t.date :start_date
    t.string :start_time
    t.date :end_date
    t.string :end_time
    t.integer :request_id

    t.belongs_to :trainer, index: true
  end
end


require_relative './models/appointment.rb'
require_relative './models/availability.rb'
require_relative './models/student.rb'
require_relative './models/trainer.rb'
require_relative './models/student_appointment.rb'

require_relative './controllers/appointments_controller.rb'
require_relative './controllers/availabilities_controller.rb'

require_relative './requests_parser_csv.rb'
require_relative './request_output_console.rb'

require_relative './services/appointment_builder.rb'

availability_builder = AvailabilitiesController.new
availability_builder.create("instructor_availability.csv")

schedule_builder = AppointmentsController.new
schedule_builder.create("input.csv")