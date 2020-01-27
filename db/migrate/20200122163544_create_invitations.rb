class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :invited
      t.references :inviting_event

      t.timestamps
    end
  end
end
