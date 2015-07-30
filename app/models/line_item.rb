class LineItem < ActiveRecord::Base
	belongs_to :product

	def for_product(product) 
		update_attribute(:quantity, 1)
		update_attribute(:product, product)
		update_attribute(:unit_price, product.price)
	end

	def self.update_quantity_by_one(li_id)
		curr = LineItem.find_by(id: li_id)
		curr.quantity += 1
	end
end
