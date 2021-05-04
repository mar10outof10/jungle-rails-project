require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    before do
      @category = Category.new(:name =>"Electronics")
    end

    it 'should create a product if all forms are filled out correctly' do
      @product = Product.create(:name => "Lamp", :price => "50", :quantity => "3", :category => @category)
      expect(@product.errors.full_messages).to match []
    end

    it 'should not create a product if the name field is left empty' do
      @productMissingAttr = Product.create(:name => nil, :price => "50", :quantity => "3", :category => @category)
      expect(@productMissingAttr.errors.full_messages[0]).to match "Name can't be blank"
    end

    it 'should not create a product if the price field is left empty' do
      @productMissingAttr = Product.create(:name => "Lamp", :price => nil, :quantity => "3", :category => @category)
      expect(@productMissingAttr.errors.full_messages[0]).to match "Price cents is not a number"
    end

    it 'should not create a product if the quantity field is left empty' do
      @productMissingAttr = Product.create(:name => "Lamp", :price => "50", :quantity => nil, :category => @category)
      expect(@productMissingAttr.errors.full_messages[0]).to match "Quantity can't be blank"
    end

    it 'should not create a product if the category is left empty' do
      @productMissingAttr = Product.create(:name => "Lamp", :price => "50", :quantity => "3", :category => nil)
      expect(@productMissingAttr.errors.full_messages[0]).to match "Category can't be blank"
    end

  end
end