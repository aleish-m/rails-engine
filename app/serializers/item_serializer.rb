class ItemSerializer
  def self.all_items(items)
    {
      data: items.map do |item|
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

  def self.single_item(item)
    {
      data: {
        id: item.id.to_s,
        type: item.class.name.downcase,
        attributes: {
          name: item.name,
          description: item.description,
          unit_price: item.unit_price,
          merchant_id: item.merchant_id
        }
      }
    }
  end

  def self.no_item(status)
    {
      status: status.to_s,
      error: {
        id: nil,
        type: Item.name.downcase,
      }
    }
  end

  def self.no_merchant_items
    {
      status: '404',
      error: [{
        id: nil,
        type: Item.name.downcase
      }]
    }
  end
end
