class AddSelfieUrlToAttendance < ActiveRecord::Migration
  def change
    change_table :attendances do |t|
      t.string :selfie_url
    end
  end
end
