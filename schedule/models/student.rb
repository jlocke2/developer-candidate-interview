class Student < ActiveRecord::Base
  has_many :appointments
  has_many :sessions, through: :appointments

  before_save :add_base_name

  validates :name, presence: true

  private

  def add_base_name
    self.base_name = self.name.convert_to_basename
  end

end