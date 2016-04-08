=begin

Hey Jason!

Running the schedule app, should only require 3 steps...
1) cd to schedule directory
2) run 'bundle install'
3) run 'ruby schedule_builder.rb'

That should do it! I look forward to having the chance to chat through the different design decisions and choices I made.

The tricky thing with coding challenges is figuring out exactly how complex and extensible a solution someone is looking
for. I tried to keep in mind the various principles of Object Oriented programming (abstraction, encapsulation,
polymorphism, and inheritance), SOLID, and TDD, yet it can be hard to convey all of this reasonably well in a small
project like this. I would love the opportunity to discuss the various design decisions I made here that way we can 
hopefully both learn together.

Oh and I'm sure there is some refactoring that could be done, but I didn't want to spend too long perfecting every detail
for the coding challenge. This should give you a good feel of my thought process and design implementations, while leaving
some extra things for us to discuss on the call.

Thanks again for this opportunity! Excited to see/hear what you think!
Alan

=end
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'interactor'
require 'ice_cube'
require 'rspec'

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
    t.string :training_type
    t.date :start_date
    t.date :end_date
    t.string :frequency
    t.string :start_time
    t.string :end_time
    t.belongs_to :student, index: true
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
require_relative './models/student.rb'
require_relative './models/trainer.rb'


require_relative './controllers/appointments_controller.rb'
require_relative './controllers/constraints_controller.rb'

require_relative './views/request_output_console.rb'

require_relative './interactors/join_appointment.rb'
require_relative './interactors/request_appointment.rb'

require_relative './lib/extend_string.rb'
require_relative './lib/requests_parser_csv.rb'

constraint_builder = ConstraintsController.new
constraint_builder.create("instructor_availability.csv")

schedule_builder = AppointmentsController.new
schedule_builder.create("input.csv")