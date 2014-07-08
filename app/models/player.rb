class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :tags, foreign_key: 'tagger_id', class_name: Tag.name
  has_many :tagged, foreign_key: 'tagee_id', class_name: Tag.name
  has_many :attendances

  validates :user_id, uniqueness: { scope: :game_id }

  ZOMBIE = 0
  HUMAN = 1

  class << self
    def update_scores
      Player.all.each(&:update_score)
    end
  end

  def update_score
    score = 0
    score += tags.count * 2
    score += attendances.count * 1
    survived_til = tagged.first.try(:time) || Time.now
    hours_survived = (survived_til - Game.current.start_time)/3600
    score += (hours_survived/12).round
    update_attribute(:score, score)
  end

  def tagged_at
    tagged.first.try(:time)
  end

  def self.generate_code
    chars = %w(A B C D E F 1 2 3 4 5 6 7 8 9)
    code = 6.times.map{chars.sample}.join
    if Player.exists?(tag_code: code)
      return Player.generate_code
    else
      return code
    end
  end

  def faction_name
    case faction
    when ZOMBIE then "Zombie"
    when HUMAN then "Human"
    end
  end

  def zombie?
    faction == ZOMBIE
  end

  def human?
    faction == HUMAN
  end

  def zombify
    faction = ZOMBIE
  end
end
