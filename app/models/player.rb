class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  ZOMBIE = 0
  HUMAN = 1
  DECEASED = 2

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
    when DECEASED then "Deceased"
    end
  end

  def zombie?
    faction == ZOMBIE
  end

  def deceased?
    last_fed + 48.hours < Time.now
  end

  def last_fed
    1.days.ago
  end
end
