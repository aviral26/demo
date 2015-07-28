class Product < ActiveRecord::Base
	validates_presence_of :title, :description, :image_url
	validates_numericality_of :price
	validates_uniqueness_of :title
	validates_format_of :image_url,
						:with    => %r{\.(gif|jpg|png)\z},
						:message =>"must be a URL for a GIF, JPG, or PNG image"
	default_scope -> { order(date_available: :desc) }
	

	def self.salable_items
		Product.where("date_available <= ?", DateTime.now.to_s(:db))
	end



	protected
		def validate
			errors.add(:price,"should be positive") unless price.nil? || price > 0.0
		end
end
