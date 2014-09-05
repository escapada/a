class StaticController < ApplicationController
	def home
		@home=true
		@prw=Dir.glob("public/images/fp_random_prw/*.jpg")
		@prw.sort_by { rand }

		#item = myArray.random_element
	end
	def about
	end
	def contact
	end
end
