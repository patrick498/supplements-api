class User < ApplicationRecord
  has_secure_password

  has_many :intakes
  has_many :supplements, through: :intakes

  validates :email_address, presence: true, uniqueness: true
  normalizes :email_address, with: -> (e) { e.strip.downcase }
end
