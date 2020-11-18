class Merchant < ApplicationRecord

  has_many :products

  validates :username, :email, presence: true, uniqueness: true

end
