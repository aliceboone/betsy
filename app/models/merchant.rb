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

  def total_revenue
    sum = 0
    merchant.order_items.each do |order_item|
      sum += order_item.single_item_total_cost
    end
    return sum
  end

end
