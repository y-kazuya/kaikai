class NoteCategory < ApplicationRecord
  has_many :notes
  belongs_to :facility, optional: true

  validates :name, presence: true
  validate :uniqe_public
  validate :uniqe_in_facility,if: lambda { !self.public }


  private
  def uniqe_public
    errors.add(:name, "同じ名前のタイプが存在します") if NoteCategory.where(public: true).where(name: name) != []
  end

  def uniqe_in_facility
    errors.add(:name, "同じ名前のタイプが存在します。") if NoteCategory.where(facility_id: self.facility.id).where(name: name) != []
  end
end
