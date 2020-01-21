class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|

      t.timestamps
    end
  end
end
