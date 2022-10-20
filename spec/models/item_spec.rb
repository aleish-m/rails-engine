require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price) } 
  end

  describe "before_destroy" do
    it "destroys invoices that have item being destroy on invoice" do
      item = create(:item)
      invoices = create_list(:invoice, 5)
      invoice_items = invoices.map{|invoice| create(:invoice_items, invoice: invoice, item: item)}

      expect(item.invoices.count).to eq(5)
      expect(Invoice.count).to eq(5)
      item.destroy
      expect(Invoice.count).to eq(0)
    end

    it "does not destroy invoices with multiple items on them" do
      items = create_pair(:item)
      invoices = create_list(:invoice, 5)
      invoice_items = invoices.flat_map do |invoice| 
        items.map do |item|
          create(:invoice_items, invoice: invoice, item: item)
        end
      end

      expect(items[0].invoices.count).to eq(5)
      expect(items[1].invoices.count).to eq(5)
      expect(Invoice.count).to eq(5)
      items[0].destroy
      expect(Invoice.count).to eq(5)
    end

    it 'only destroys invoices where the only item on invoice is the item being destroyed' do
      items = create_pair(:item)
      invoices = create_list(:invoice, 2)
      items.map do |item|
          create(:invoice_items, invoice: invoices[0], item: item)
      end
      create(:invoice_items, invoice: invoices[1], item: items[0])
      
      expect(items[0].invoices.count).to eq(2)
      expect(items[1].invoices.count).to eq(1)
      expect(Invoice.count).to eq(2)
      items[0].destroy
      expect(Invoice.count).to eq(1)
      expect(items[1].invoices.count).to eq(1)
    end
  end
end
