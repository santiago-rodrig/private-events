class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.references :attendee
      t.references :attended_event

      t.timestamps
    end
  end
end
