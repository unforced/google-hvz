class Mission < ActiveRecord::Base
  has_many :attendances
end
