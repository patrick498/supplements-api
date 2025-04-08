class Supplement < ApplicationRecord
  has_many :intakes

  validates :name, presence: true, uniqueness: true
end
