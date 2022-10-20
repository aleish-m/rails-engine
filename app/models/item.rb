class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  
  validates_presence_of :name, :description, :unit_price
  validates :unit_price, numericality:
  
  before_destroy(:delete_invoices, prepend: true)
  
  private

  def delete_invoices
    invoices.find_invoices_with_one_item.each {|invoice| invoice.destroy}
  end
end
