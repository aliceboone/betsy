class Product < ApplicationRecord

  belongs_to :merchant


  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :merchant, presence: true

  def self.category1
    where(category: "category1")
  end

  def self.category2
    where(category: "category2")
  end

  def self.category3
    where(category: "category3")
  end

  def self.category4
    where(category: "category4")
  end
end
