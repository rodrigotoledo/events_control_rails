class Participant < ApplicationRecord
  validates :name, :email, :uid, presence: true
  validates :email, :uid, uniqueness: true
end
