class Product < ApplicationRecord

  belongs_to :merchant
  has_and_belongs_to_many :categories

  has_many :reviews

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :merchant, presence: true

  scope :available, -> { where(discontinued: false).where.not(inventory: 0) }

  def out_of_stock
    self.inventory == 0
  end

  def average_rating
    avg_rating = reviews.where.not(rating: nil).sum(:rating)
    total_reviews = reviews.count(:rating)

    return nil if total_reviews.zero? || avg_rating.zero?

    avg_rating /= total_reviews

    return avg_rating
  end

  def decrease_inventory(amount_to_decrease)
    self.inventory -= amount_to_decrease
  end

end