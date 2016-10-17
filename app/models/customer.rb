class Customer < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  has_many :cards
end
