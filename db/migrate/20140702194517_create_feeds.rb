class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :tag_id
      t.integer :player_id
      t.datetime :time

      t.timestamps
    end
  end
end
