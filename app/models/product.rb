class Product < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  has_many :reviews



  validates :name, presence: true, uniqueness: true
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
end