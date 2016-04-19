class Student < ActiveRecord::Base
  has_many :appointments
  has_many :trainers, through: :appointments

  before_validation(on: :create) do
    self.base_name = name.convert_to_basename if name
  end

  validates :name, presence: true
  validates :base_name, presence: true

end