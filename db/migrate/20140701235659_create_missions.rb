class CreateMissions < ActiveRecord::Migration
  def change
    create_table :missions do |t|
      t.datetime :time
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
