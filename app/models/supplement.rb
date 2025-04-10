class Supplement < ApplicationRecord
  has_many :intakes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
