class Tag < ActiveRecord::Base

  belongs_to :tagger, class_name: Player
  belongs_to :tagee, class_name: Player

  validate :validate_tagger
  validate :validate_tagee
  validate :validate_time

  after_save :zombify
  after_save :award_points, unless: :admin_tag
  
  def tag_code=(tag_code)
    self.tagee = Player.find_by(tag_code: tag_code)
  end

  def tag_code
    #This is dumb, but I don't have documentation on the airplane
  end

  def validate_tagee
    unless tagee
      errors.add(:tagee, 'No player was found with that tag code.')
      return
    end
    errors.add(:tagee, 'Must be a human') unless tagee.human?
    errors.add(:tagee, 'Must be in the current game') unless tagee.game == Game.current
  end

  def validate_tagger
    return if admin_tag
    unless tagger
      errors.add(:tagger, 'Must not be nil')
      return
    end
    errors.add(:tagger, 'Must be a zombie') unless tagger.zombie?
    errors.add(:tagger, 'Must be in the current game') unless tagger.game == Game.current
  end

  def validate_time
    errors.add(:time, 'Must not be in the future') if time.future?
  end

  def zombify
    tagee.update_attribute(:faction, Player::ZOMBIE)
  end

  def award_points
    tagger.increment!(:score, 2)
  end
end
