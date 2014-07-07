class Tag < ActiveRecord::Base

  belongs_to :tagger, class_name: Player
  belongs_to :tagee, class_name: Player
  has_many :feeds

  validates_associated :feeds

  validate :validate_tagger
  validate :validate_tagee
  validate :validate_time

  before_save :feed_self
  before_save :zombify
  before_save :award_points
  
  def tag_code=(tag_code)
    self.tagee = Player.find_by(tag_code: tag_code)
  end

  def tag_code
    #This is dumb, but I don't have documentation on the airplane
  end

  def first_feed=(feedee_id)
    self.feeds << Feed.new(player_id: feedee_id, time: Time.now)
  end

  def second_feed=(feedee_id)
    first_feed=feedee_id
  end

  def first_feed;end
  def second_feed;end

  def validate_tagee
    unless tagee
      errors.add(:tagee, 'No player was found with that tag code.')
      return
    end
    errors.add(:tagee, 'Must be a human') unless tagee.human?
    errors.add(:tagee, 'Must be in the current game') unless tagee.game == Game.current
  end

  def validate_tagger
    errors.add(:tagger, 'Must be a zombie') unless tagger.zombie?
    errors.add(:tagger, 'Must not be deceased') if tagger.deceased?
    errors.add(:tagger, 'Must be in the current game') unless tagger.game == Game.current
  end

  def validate_time
    errors.add(:time, 'Must not be in the future') if time.future?
  end

  def feed_self
    self.feeds << Feed.new(player_id: self.id, time: Time.now)
  end

  def zombify
    tagee.zombify
  end

  def award_points
    tagger.increment(:points, 2)
  end
end
