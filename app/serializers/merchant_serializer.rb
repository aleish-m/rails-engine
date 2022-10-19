class MerchantSerializer 

  def self.all_merchants(merchants)
    {
      data: merchants.map do |merchant|
        {
         id: merchant.id.to_s,
         type: merchant.class.name.downcase,
         attributes: {
          name: merchant.name
         }
        }
      end
    }
  end

  def self.single_merchant(merchant)
    {
      data: {
         id: merchant.id.to_s,
         type: merchant.class.name.downcase,
         attributes: {
          name: merchant.name
         }
        }
    }
  end

  def self.items_for_merchant(merchant)
    {
      data: merchant.items.map do |item|
        {
          id: item.id.to_s, 
          type: item.class.name.downcase,
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  def self.no_merchant
    {
      status: '404',
      error: {
         id: nil,
         type: Merchant.name.downcase,
         attributes: {
          name: ''
         }
        }
    }
  end

  def self.no_merchant_items
    {
      status: '404',
      error: [{
        id: nil,
        type: Item.name.downcase,
        attributes: {
          name: '',
          description: '',
          unit_price: nil,
          merchant_id: nil
        }
      }]
    }
  end
end
