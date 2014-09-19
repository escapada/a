class StaticController < ApplicationController
	def index
		@title="ООО АВС-Принт"
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"

		@prw=Array.new()
		Dir.glob("public/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!

		render :layout => 'blank'
	end
	def home
		@home=true
		@prw=Array.new()
		Dir.glob("public/images/fp_random_prw/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def about
		@title="О нас. АВС-Принт."
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"

		@prw=Array.new()
		Dir.glob("public/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def contact
		@title="Контакты. АВС-Принт. Санкт-Петербург, Химический пер. 1 (въезд с ул.Трефолева 1 литер П). тел. 7027840, 7027841"
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"
	end
	def trebovaniya
		@title="Технические требования к макетам."
		@meta="полиграфия, шелкография, требования к макетам, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции"

		@prw=Array.new()
		Dir.glob("public/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def vizitki
		@title="Онлайн калькулятор. Шелкотрафаретная, цифровая, полноцветная печать визиток. Постобработка. Вырубка, тиснение, лакировка. Online calculate."
		@meta="визитки, дизайн, малотиражное производство, шелкография, печать визиток"

		@vizitki=true
		@printer = Paper.printer
		@noprinter = Paper.find(:all)

		@prw=Array.new()
		Dir.glob("public/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
end