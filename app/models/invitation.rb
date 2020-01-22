class Invitation < ApplicationRecord
  belongs_to :invited, class_name: 'User'
  belongs_to :inviting_event, class_name: 'Event'
end
