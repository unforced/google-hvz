class Game < ActiveRecord::Base
  has_many :players

  # TODO: Potentially make this customizable, but for now, not worth it
  def self.current
    Game.last
  end

  def zombies
    players.where(faction: Player::ZOMBIE)
  end
end
