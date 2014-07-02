class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :mission_id
      t.integer :player_id

      t.timestamps
    end
  end
end
