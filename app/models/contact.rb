class Contact < ApplicationRecord

  validates :name,:email,:content,:kind, presence: true

  enum kind: {
    ご質問:  1, ご意見: 2, ご感想: 3, 不具合・バグ報告: 4, ご要望: 5, 励まし: 6, その他: 7
  }
end
