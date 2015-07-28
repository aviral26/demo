class StoreController < ApplicationController
  def index
  	@products = Product.salable_items
  end
  def add_to_cart
  end
end
