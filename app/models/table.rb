class Table < ActiveRecord::Base
	has_many :bookings
	scope :create_new, -> {create!(:name=>"Table_1", :code => "A45679DF")}
end
