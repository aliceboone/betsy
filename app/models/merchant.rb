class Merchant < ApplicationRecord

  has_many :products

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: true


  def self.build_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    merchant.provider = "github"
    merchant.username = auth_hash["info"]["name"] || auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]
    return merchant
  end

  def revenue(orders, merchant)
    order_items = OrderItem.where(merchant: merchant)

    order_items.each do |item|
      item.price * item.quantity


  end
  end

end
