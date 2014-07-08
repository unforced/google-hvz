class Attendance < ActiveRecord::Base
  belongs_to :mission
  belongs_to :player

  validates :player, presence: true
  validates :mission_id, uniqueness: { scope: :player_id }

  after_create :award_points

  # On attending, award player 1 point
  def award_points
    player.increment!(:score, 1)
  end
end
