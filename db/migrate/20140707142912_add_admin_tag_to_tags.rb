class AddAdminTagToTags < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.boolean :admin_tag
    end
  end
end
