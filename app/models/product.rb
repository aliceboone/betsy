class Product < ApplicationRecord

  belongs_to :merchant
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :merchant, presence: true


  def out_of_stock
    return self.inventory == 0
  end


end
