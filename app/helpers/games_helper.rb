module GamesHelper
  def zombie?
    current_user.try(:player).try(:zombie?)
  end
end
