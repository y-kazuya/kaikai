class EventsUser < ApplicationRecord
  belongs_to :event
  belogs_to :user
end
