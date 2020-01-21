class AddUserIdToEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.references :user
    end

    add_index :events, :user_id, unique: true
  end
end
