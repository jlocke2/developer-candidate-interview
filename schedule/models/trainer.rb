class Trainer < ActiveRecord::Base
  has_many :sessions
  has_many :constraints

  before_save :add_base_name

  validates :base_name, presence: true

  private

  def add_base_name
    self.base_name = name.convert_to_basename if name
  end


end