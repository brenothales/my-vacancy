require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should have a name' do
    category = Category.new(:name => nil)
    assert !category.save, 'should have a name'
  end

  test 'should be uniq' do 
    category = Category.new(:name => 'Venda')
    category.save
    category_dois = Category.new(:name => 'Venda')
    assert !category_dois.save, 'should be uniq'  
  end

end
