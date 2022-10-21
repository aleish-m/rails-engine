class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality:
  
  before_destroy(:delete_invoices, prepend: true)

  def self.search_names(search)
    where("name ILIKE '%#{search}%'")
    .order(:name)
  end

  def self.search_price(search)
    if search[:max_price].present? && search[:min_price].present?
      where("unit_price <= #{search[:max_price]} and unit_price >= #{search[:min_price]}")
      .order(:unit_price)
    elsif search[:max_price].present?
      where("unit_price <= #{search[:max_price]}")
      .order(:unit_price)
    elsif search[:min_price].present?
      where("unit_price >= #{search[:min_price]}")
      .order(:unit_price)
    end
  end
  
  private

  def delete_invoices
    invoices.find_invoices_with_one_item.each {|invoice| invoice.destroy}
  end
end
