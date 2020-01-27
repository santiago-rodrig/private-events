class AddUserIdToEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.references :user # this also adds an index
    end
  end
end
