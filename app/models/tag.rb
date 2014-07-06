class Tag < ActiveRecord::Base

  belongs_to :tagger, class_name: Player
  belongs_to :tagee, class_name: Player
  has_many :feeds

  validate :validates_tagger
  
  def tag_code=(tag_code)
    self.tagee = Player.find_by(tag_code: tag_code)
  end

  def first_feed=(feedee_id)
    self.feeds << Feed.new(player_id: feedee_id, time: Time.now)
  end

  def validate_tagee
    unless tagee
      errors.add(:tagee, 'No player was found with that tag code.')
      return
    end
    errors.add(:tagee, 'Must be a human') unless tagee.human?
    errors.add(:tagee, 'Must be in the current game') unless tagee.game == Game.current
  end

  def validates_tagger
    errors.add(:tagger, 'Must be a zombie') unless tagger.zombie?
    errors.add(:tagger, 'Must not be deceased') if tagger.deceased?
    errors.add(:tagger, 'Must be in the current game') unless tagger.game == Game.current
  end
end
