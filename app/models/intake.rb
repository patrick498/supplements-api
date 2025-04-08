class Intake < ApplicationRecord
  belongs_to :user
  belongs_to :supplement
end
