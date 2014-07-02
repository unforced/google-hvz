class AddFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :email
      t.string :ldap
      t.boolean :admin
    end
  end
end
