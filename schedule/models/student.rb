class Student < ActiveRecord::Base
  has_many :student_appointments
  has_many :appointments, through: :student_appointments

  before_save :add_base_name

  private

  def add_base_name
    self.base_name = name.gsub(/[^a-z\s\_]/i, '').split.join(" ").downcase.gsub(/\s+/,"_")
  end

end