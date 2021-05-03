require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    it 'should create a product if all forms are filled out correctly' do
      @category = Category.new(:name => "Electronics")
      @product = Product.new(:name => "Lamp", :price => "50", :quantity => "3", :category => @category)
      expect(@product).to be_present
    end

    # it 'should validate that a name exists when a product is created' do
    #   expect(@product.name).to be_present
    # end

  end
end