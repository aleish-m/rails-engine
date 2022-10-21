class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :items

  def self.search_names(search)
    where("name ILIKE '%#{search[:name]}%'")
    .order(:name).limit(1).first
  end
end
