require 'rails_helper'

RSpec.feature "Visitor navigates to product page", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
    
  end

  scenario "They can navigate to the product detail page by clicking on a product" do

    @category.products.create!(
      name: 'Blue Jeans',
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )

    visit root_path

    click_on 'Blue Jeans'
    
    sleep 1

    expect(page).to have_css '.product-detail'

  end
end