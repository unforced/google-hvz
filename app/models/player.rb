class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  validates :user_id, uniqueness: { scope: :game_id }

  ZOMBIE = 0
  HUMAN = 1

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
