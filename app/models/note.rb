class Note < ApplicationRecord
  belongs_to :note_category,optional: true
  belongs_to :user


end
