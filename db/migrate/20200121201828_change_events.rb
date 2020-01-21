class ChangeEvents < ActiveRecord::Migration[5.1]
  def change
    change_table :events do |t|
      t.rename :name, :description
      t.change :description, :text
    end
  end
end
