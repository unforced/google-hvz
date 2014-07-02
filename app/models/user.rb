class User < ActiveRecord::Base
  has_many :players

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
         user.ldap = user.email[/(.*)@google.com/, 1] || ""
      end
    end
  end

  def registered?(game = Game.current)
    players.exists?(game_id: game)
  end

  def player(game = Game.current)
    players.where(game_id: game).first
  end

end
