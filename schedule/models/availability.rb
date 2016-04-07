class Availability < ActiveRecord::Base
  belongs_to :trainer

  attr_accessor :name
end