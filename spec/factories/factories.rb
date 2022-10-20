FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
  end

  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { Faker::Number.within(range: 500..2000) }
    association :merchant, factory: :merchant
  end

  factory :invoice, class: Invoice do
    status {Faker::Number.within(range: 0..2)}
  end

  factory :invoice_items, class: InvoiceItem do
    quantity {Faker::Number.within(range: 1..20)}
    unit_price {Faker::Number.within(range: 500..2000)}
    status {Faker::Number.within(range: 0..2)}
    association :invoice, factory: :invoice
    association :item, factory: :item
  end
end
