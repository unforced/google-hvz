class Feed < ActiveRecord::Base
  validate :validations

  def validations
    errors.add(:time, 'must not be in the future') if time.future?
    errors.add(:player, 'must be a zombie') unless player.zombie?
  end
end
