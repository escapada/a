class StaticController < ApplicationController
	def index
		@title="ООО АВС-Принт"
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!

		render :layout => 'blank'
	end
	def home
		@home=true
		@prw=Array.new()
		Dir.glob("app/assets/images/fp_random_prw/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def about
		@static=true
		@title="О нас. АВС-Принт."
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def contact
		@static=true
		@contact=true
		@title="Контакты. АВС-Принт. Санкт-Петербург, Химический пер. 1 (въезд с ул.Трефолева 1 литер П). тел. 7027840, 7027841"
		@meta="полиграфия, шелкография, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции, тиснение, вырубка, УФ-лак, дизайн"
	end
	def trebovaniya
		@static=true
		@title="Технические требования к макетам."
		@meta="полиграфия, шелкография, требования к макетам, печать на пакетах, печать визиток, брошюр, листовок, календарей, буклетов, рекламной продукции"

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def vizitki
		@title="Онлайн калькулятор. Шелкотрафаретная, цифровая, полноцветная печать визиток. Постобработка. Вырубка, тиснение, лакировка. Online calculate."
		@meta="визитки, дизайн, малотиражное производство, шелкография, печать визиток"

		@remotejs="vizitki"
		@vizitki=true
		@printer = Paper.printer
		@noprinter = Paper.find(:all)

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end
	def cards
		@title="Онлайн калькулятор. Шелкотрафаретная, цифровая, полноцветная печать открыток, приглашений. Постобработка. Вырубка, тиснение, лакировка. Online calculate."
		@meta="открытки, приглашения, дизайн, малотиражное производство, шелкография, печать открыток"

		@remotejs="cards"
		@cards=true
		@printer = Paper.printer
		@noprinter = Paper.find(:all)

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end






	def silk
		@title="Онлайн калькулятор. Шелкотрафаретная печать, шелкография, печать на дизайнерской бумаге. Online calculate."
		@meta="шелкография, малотиражное производство, печать, дизайн"

		@remotejs="silk"
		@silk=true
		@noprinter = Paper.find(:all)

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def printer
		@title="Онлайн калькулятор. Цифровая малотиражная печать. Online calculate."
		@meta="цифровая печать, малотиражное производство, печать, дизайн"

		@remotejs="printer"
		@printer=true
		@printer = Paper.printer
		@format = Printerconstant.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def tisnenie
		@title="Онлайн калькулятор. Тиснение. Online calculate."
		@meta="тиснение, малотиражное производство, печать, дизайн"

		@remotejs="tisnenie"
		@paper = Paper.find(:all)
		@format = Format.where("tisnenieVyrubkaLak = '1'")
		#@format = Format.where("format = 'A4' OR format = 'A3' OR format = 'A2'")		##the same## @format = Format.find([4,5,6])
		#@format = Format.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def vyrubka
		@title="Онлайн калькулятор. Вырубка. Online calculate."
		@meta="вырубка, малотиражное производство, печать, дизайн, постпечатная обработка"

		@remotejs="vyrubka"
		@paper = Paper.find(:all)
		@format = Format.where("tisnenieVyrubkaLak = '1'")
		#@format = Format.where("format = 'A4' OR format = 'A3' OR format = 'A2'")		##the same## @format = Format.find([4,5,6])
		#@format = Format.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def lak
		@title="Онлайн калькулятор. УФ-лак. Online calculate."
		@meta="УФ-лак, малотиражное производство, печать, дизайн, постпечатная обработка"

		@remotejs="lak"
		@paper = Paper.find(:all)
		@format = Format.where("tisnenieVyrubkaLak = '1'")
		#@format = Format.where("format = 'A4' OR format = 'A3' OR format = 'A2'")		##the same## @format = Format.find([4,5,6])
		#@format = Format.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def upprint
		@title="Онлайн калькулятор. Верхняя печать / Леттерпресс. Online calculate."
		@meta="Верхняя печать / Леттерпресс, малотиражное производство, печать, дизайн, постпечатная обработка"

		@remotejs="upprint"
		@paper = Paper.find(:all)
		@format = Format.where("letterpress = '1'")
		#@format = Format.where("format = 'A4' OR format = 'A3' OR format = 'A2'")		##the same## @format = Format.find([4,5,6])
		#@format = Format.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end

	def plasticfolders
		@title="Онлайн калькулятор. Папки-уголки (пластик). Online calculate."
		@meta="Папки-уголки (пластик), шелкография на папке, пластиковые папки с печатью, с нанесением"

		@remotejs="plasticfolders"
		#@paper = Paper.find(:all)
		#@format = Format.where("letterpress = '1'")
		#@format = Format.where("format = 'A4' OR format = 'A3' OR format = 'A2'")		##the same## @format = Format.find([4,5,6])
		#@format = Format.all

		@prw=Array.new()
		Dir.glob("app/assets/images/tmpallstuff/*.jpg"){|x| @prw << File.basename(x)}
		@prw.shuffle!
	end


end