class Trainer < ActiveRecord::Base
  has_many :appointments

  has_many :availabilities

  before_save :add_base_name

  private

  def add_base_name
    self.base_name = name.gsub(/[^a-z\s\_]/i, '').split.join(" ").downcase.gsub(/\s+/,"_") if name
  end


end