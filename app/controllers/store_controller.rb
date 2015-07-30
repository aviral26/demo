class StoreController < ApplicationController

  def index
  	  @products = Product.salable_items
  end

  def add_to_cart
      product = Product.find(params[:id])
	    @cart_items = find_cart_items
      @cart_total_price = find_cart_total_price.to_f
	    item = @cart_items.find {|i| i['product_id'] == product.id}
      if item
        LineItem.update_quantity_by_one item['id']
        item['quantity'] += 1
      else
        li = LineItem.new
        if li.save
          li.for_product(product)
          @cart_items << li
        else
          flash[:alert] = "Error encountered."
        end
      end

      #@cart_items << LineItem.for_product(product)
      @cart_total_price += product.price
      session[:cart_total_price] = @cart_total_price
	    redirect_to display_cart_path
  end

  def display_cart
      @items = session[:cart_items]
      @cart_total_price = find_cart_total_price
  end

  private 
	def find_cart_items
  		if session[:cart_items].nil?
        session[:cart_items] = Array.new
      else
        session[:cart_items]
      end
	end
  def find_cart_total_price
    if session[:cart_total_price].nil?
      session[:cart_total_price] = 0
    else
      session[:cart_total_price]
    end
  end
end
