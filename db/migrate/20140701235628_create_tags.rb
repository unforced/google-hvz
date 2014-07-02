class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tagger_id
      t.integer :tagee_id
      t.datetime :time

      t.timestamps
    end
  end
end
