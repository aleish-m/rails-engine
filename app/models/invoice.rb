class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant 
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy 
  has_many :items, through: :invoice_items

  def self.find_invoices_with_one_item
    Invoice.joins(:items)
    .group(:id)
    .having('count(invoice_items.item_id) = 1')
  end
end
