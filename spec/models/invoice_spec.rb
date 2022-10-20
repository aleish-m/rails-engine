require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) } 
    it { should belong_to(:merchant) } 
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'class methods' do
    describe '#find_invoices_with_one_item' do
      it "finds all invoices that only have 1 item on them" do 
        invoices = create_list(:invoice, 5)

        invoices[0].items << create(:item)
        invoices[0].items << create(:item)

        invoices[1].items << create(:item)

        invoices[2].items << create(:item)
        invoices[2].items << create(:item)

        invoices[3].items << create(:item)
        invoices[3].items << create(:item)
        invoices[3].items << create(:item)

        invoices[4].items << create(:item)

        expect(Invoice.find_invoices_with_one_item).to eq([invoices[1], invoices[4]])
      end
    end
  end
end
