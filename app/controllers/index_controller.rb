class IndexController < ApplicationController
	def index
		@papers = Paper.find(:all)
	end

	def vizitki_calculate
		vizitkiConstants = Vizitkiconstant.find(:first)
		constants = Constant.find(:first)

		dollar = constants.dollar
		euro = constants.euro
		koeficient = constants.koeficient # множитель для цифровой печати на визитках
		percent = constants.percent
		
		setFirstColor = vizitkiConstants.setFirstColor
		setNextColor = vizitkiConstants.setNextColor
		prokatPrint = vizitkiConstants.prokatPrint
		setUF = vizitkiConstants.setUF
		prokatUF = vizitkiConstants.prokatUF
		setUFUp = vizitkiConstants.setUFUp
		prokatUFUp = vizitkiConstants.prokatUFUp
		setTisnenie = vizitkiConstants.setTisnenie
		tisnenieBlint = vizitkiConstants.tisnenieBlint
		tisnenieFolga = vizitkiConstants.tisnenieFolga
		tisnenieKongrev = vizitkiConstants.tisnenieKongrev
		klishe = vizitkiConstants.klishe
		termopod = vizitkiConstants.termopod
		obrez = vizitkiConstants.obrez
		kruglenie = vizitkiConstants.kruglenie
		setVyrubka = vizitkiConstants.setVyrubka
		vyrubka = vizitkiConstants.vyrubka
		shtamp = vizitkiConstants.shtamp
		
		#dollar = 38		euro = 50		koeficient = 1 	percent = 30		setFirstColor = 300		setNextColor = 150
		#prokatPrint = 4		setUF = 1200		prokatUF = 5		setUFUp = 1700		prokatUFUp = 7		setTisnenie = 750
		#tisnenieBlint = 3		tisnenieFolga = 5		tisnenieKongrev = 5		klishe = 500		termopod = 500
		#obrez = 300		kruglenie = 1		setVyrubka = 750		vyrubka = 3		shtamp = 1500

		dopSum = Array.new()
		dp = params[:dp].split(/,/)

		color = params[:color]
		tirazh = params[:tirazh].to_i

		nextColorCount = 0
		prokatCount = tirazh/4
		colorCount = 1
		
		if params[:paper]
			paperInstance = Paper.find(params[:paper])
			case paperInstance.currency
			when 'd' then paperPrice = dollar*paperInstance.price
			when 'e' then paperPrice = euro*paperInstance.price
			when 'r' then paperPrice = paperInstance.price
			end						
		end

		if params[:nopaper]
			paperPrice = params[:nopaper].to_f
			#percent = 0		
		end

		if params[:printer] == "true"
			case color
			when '1'
				print = koeficient*Cyfravizitka.find(:first, :conditions => "tirazh = '#{tirazh}'").price
			when '2'
				print = koeficient*Cyfravizitka.find(:first, :conditions => "tirazh = '#{tirazh}'").price2
			end
		else
			case color
			when '1+0' then nextColorCount = 0
			when '2+0' 
			nextColorCount = 1
			colorCount = 2
			when '3+0'
			nextColorCount = 2
			colorCount = 3
			when '4+0'
			nextColorCount = 3
			colorCount = 4
			#####
			when '1+1'
			nextColorCount = 0
			colorCount = 1
			prokatCount *= 2
			when '2+2', '2+1'
			nextColorCount = 1
			colorCount = 2
			prokatCount *= 2
			when '3+3', '3+2', '3+1'
			nextColorCount = 2
			colorCount = 3
			prokatCount *= 2
			when '4+4', '4+3', '4+2', '4+1'
			nextColorCount = 3
			colorCount = 4
			prokatCount *= 2 
			end

			print = setFirstColor + setNextColor*nextColorCount + prokatCount*prokatPrint*colorCount
		end


		if(dp[0]=="1")
			if(params[:klishe_blint]=="0")
				dopSum << setTisnenie+klishe+tirazh*tisnenieBlint
			else
				dopSum << setTisnenie+tirazh*tisnenieBlint
			end
		end
		if(dp[1]=="1")
			if(params[:klishe_folga]=="0")
				dopSum << setTisnenie+klishe+tirazh*tisnenieFolga
			else
				dopSum << setTisnenie+tirazh*tisnenieFolga
			end
		end
		if(dp[2]=="1")
			if(params[:klishe_kongrev]=="0")
				dopSum << setTisnenie+klishe+tirazh*tisnenieKongrev
			else
				dopSum << setTisnenie+tirazh*tisnenieKongrev
			end
		end
		if(dp[3]=="1")
			dopSum << setUF+prokatCount*prokatUF
		end
		if(dp[4]=="1")
			dopSum << setUFUp+prokatCount*prokatUFUp
		end
		if(dp[5]=="1")
			dopSum << termopod*tirazh/100
		end
		if(dp[6]=="1")
			dopSum << obrez*tirazh/100
		end
		if(dp[7]=="1")
			dopSum << kruglenie*tirazh
		end
		if(dp[8]=="1")
			if(params[:vyrubka]=="0")
				dopSum << setVyrubka+shtamp+tirazh*vyrubka
			else
				dopSum << setVyrubka+tirazh*vyrubka
			end
		end

		bumaga = (paperPrice + paperPrice*percent/100)*tirazh/100
		obrabotka = dopSum.sum 
		
		result = bumaga + print + obrabotka
		

		@tmp1 = "#{(result).round(2)} руб."#obrabotka#dopSum#bumaga#tirazh

		#render json: @tmp1
		#render text: @tmp1
		
		render :text => @tmp1

	end

	def silk_calculate
		silkConstants = Silkconstant.where("format = '#{params[:format]}'").first
		constants = Constant.find(:first)

		dollar = constants.dollar
		euro = constants.euro
		percent = constants.percent
		
		setFirstColor = silkConstants.setFirstColor
		setNextColor = silkConstants.setNextColor
		
		color = params[:color]
		tirazh = params[:tirazh].to_i
		format = params[:format]

		nextColorCount = 0
		colorCount = 1
		
		if params[:paper]
			paperInstance = Paper.find(params[:paper])
			case paperInstance.currency
			when 'd' then paperPrice = dollar*paperInstance.price
			when 'e' then paperPrice = euro*paperInstance.price
			when 'r' then paperPrice = paperInstance.price
			end						
		end

		if params[:nopaper]
			paperPrice = params[:nopaper].to_f	
		end

		case color
		when '1+0' then nextColorCount = 0
		when '2+0', '1+1' 
		nextColorCount = 1
		colorCount = 2
		when '3+0', '2+1'
		nextColorCount = 2
		colorCount = 3
		when '4+0', '2+2', '3+1'
		nextColorCount = 3
		colorCount = 4
		when '3+2', '4+1'
		nextColorCount = 4
		colorCount = 5
		when '3+3', '4+2'
		nextColorCount = 5
		colorCount = 6 
		when '4+3'
		nextColorCount = 6
		colorCount = 7 
		when '4+4'
		nextColorCount = 7
		colorCount = 8 
		end

		case format
		when 'A4'
			remainder = tirazh%9
			if remainder>0
				listCount = tirazh/9+1
			else
				listCount = tirazh/9
			end
		when 'A3'
			remainder = tirazh%4
			if remainder>0
				listCount = tirazh/4+1
			else
				listCount = tirazh/4
			end
		when 'A2'
			remainder = tirazh%2
			if remainder>0
				listCount = tirazh/2+1
			else
				listCount = tirazh/2
			end
		end
		
		bumaga = (paperPrice + paperPrice*percent/100)*listCount
		###считаем сколько стоит один прокат. в процентах вычисляем, куда попал тираж от 1 до 5000 (1% до 100%) и соответственно ценник: чем ближе к 100%, тем дешевле за единицу печати. как-то так.
		prokatPrint = silkConstants.prokat_100-(silkConstants.prokat_100-silkConstants.prokat_5000)*tirazh/5000
		###
		print = setFirstColor + setNextColor*nextColorCount + tirazh*prokatPrint*colorCount
		
		result = bumaga + print
	
		@tmp1 = "#{(result).round(2)} руб."#obrabotka#dopSum#bumaga#tirazh
		
		render :text => @tmp1

	end

	def printer_calculate
		printerConstants = Printerconstant.find(params[:format])
		constants = Constant.find(:first)

		dollar = constants.dollar
		euro = constants.euro
		percent = constants.percent
		koeficient = constants.koeficient # множитель для цифровой печати (такой же на визитках)
		priceBigovka = constants.meloch
		
		tirazh = params[:tirazh].to_i
		color = params[:color]
		#format = params[:format]
		
		#далее цену стандартного большого листа делем на 4 (получаем цену A3 формата)
		#так как везде далее в рассчётах привязка к A3
		if params[:paper]
			paperInstance = Paper.find(params[:paper])
			case paperInstance.currency
			when 'd' then paperPrice = dollar*paperInstance.price/4
			when 'e' then paperPrice = euro*paperInstance.price/4
			when 'r' then paperPrice = paperInstance.price/4
			end						
		end

		if params[:nopaper]
			paperPrice = (params[:nopaper].to_f)/4
		end

		tech = 3 	#баксы за работу/тех.обслуживание видимо. добавляется ко всему тиражу
		
		#печать во всех форматах рассчитывается из цены печати на А3 формате,
		#соответственно нужен этот коэффициент:
		k = printerConstants.a3
		
		#при перевале в 75*k(38*k при двусторонней печати А3-х листов вычитается. 
		#пока не понятно, но наверное, так как только количество прокатов на машине 
		#влияет на то когда делать этот вычет, то скорее всего после этого рубежа 
		#меняется печатная машина на более высокий класс с более высокими тиражами, 
		#где и цена за прокат падает и необходима корректировка в последовательности 
		#ценообразования, для чего и делается этот вычет. 
		#вычеты разные для одно/двусторонней печати (vychet/vychet2), как и все дэльты. 
		#как-то так: 
		case color
		when '1'	#односторонняя печать
			vychet = 3.75 				
			delta_1 = 0.75
			delta_2 = 0.7
			delta_3 = 0.18
			delta_4 = 0.15
			case tirazh
			when 1...k*75
				print = delta_1*tirazh+tech
			when k*75
				print = (delta_1*tirazh-vychet)+tech	#здесь вот тута и делается вычет, корректировка. дальше всё ровно как бэ
			when k*75+1..k*100
				delta = delta_1*k*75-vychet
				print = (delta+delta_2*(tirazh-k*75))+tech
			when k*100+1..k*1000
				delta = (delta_1*k*75-vychet)+(delta_2*k*25)	#до 75 одна дельта на 25 другая ну а после 100 третья, такая петрушка 
				print = (delta+delta_3*(tirazh-k*(75+25)))+tech
			else	#если тираж больше k*1000
				delta = (delta_1*k*75-vychet)+(delta_2*k*25)+(delta_3*k*900)
				print = (delta+delta_4*(tirazh-k*(75+25+900)))+tech
			
			end
		when '2'	#двусторонняя печать
			vychet2 = 2.3
			delta_1 = 1.5
			delta_2 = 1.4
			delta_3 = 0.36
			delta_4 = 0.3
			case tirazh
			when 1...k*38 #без верхней границы
				print = delta_1*tirazh+tech
			when k*38
				print = (delta_1*tirazh-vychet)+tech	#здесь вот тута и делается вычет, корректировка. дальше всё ровно как бэ
			when k*38+1..k*50
				delta = delta_1*k*38-vychet
				print = (delta+delta_2*(tirazh-k*38))+tech
			when k*50+1..k*500
				delta = (delta_1*k*38-vychet)+(delta_2*k*22)	#до 75 одна дельта на 25 другая ну а после 100 третья, такая петрушка 
				print = (delta+delta_3*(tirazh-k*(38+22)))+tech
			else	#если тираж больше k*500
				delta = (delta_1*k*38-vychet)+(delta_2*k*22)+(delta_3*k*450)
				print = (delta+delta_4*(tirazh-k*(38+22+450)))+tech
			
			end
			
		end						

		remainder = tirazh%k 	#проверяем кратность A3, и дальше если не кратно добавляем 1 лист A3

		if remainder>0
			listCount = tirazh/k+1
		else
			listCount = tirazh/k
		end 
		
		bumaga = paperPrice*listCount
		#(paperPrice + paperPrice*percent/100)*listCount+printerConstants.bigovka*priceBigovka*tirazh
		###считаем (с одной/ или с двусторонней печатью) сколько стоит один прокат. в процентах вычисляем, куда попал тираж от 1 до 5000 (1% до 100%) и соответственно ценник: чем ближе к 100%, тем дешевле за единицу печати. как-то так.
		#case color
			#when '1'
			#prokatPrint = printerConstants.firstPrintPrice-(printerConstants.firstPrintPrice-printerConstants.lastPrintPrice)*tirazh/5000
			#when '2'
			#prokatPrint = printerConstants.firstPrintPrice2-(printerConstants.firstPrintPrice2-printerConstants.lastPrintPrice2)*tirazh/5000
		#end
		###
		
		result = bumaga + koeficient*print
		#result = bumaga + koeficient*print*dollar
	
		@tmp1 = "#{print}  #{k}  #{listCount}"# руб."#obrabotka#dopSum#bumaga#tirazh
		
		render :text => @tmp1

	end


	def tisnenie_calculate
		formats = Format.find(params[:format])
		tisnenieConstants = Tisnenieconstant.find(:first)
		constants = Constant.find(:first)

		dollar = constants.dollar
		euro = constants.euro
		percent = constants.percent

		priladka = tisnenieConstants.priladka
		tisnenieBlint = tisnenieConstants.tisnenieBlint
		tisnenieFolga = tisnenieConstants.tisnenieFolga
		tisnenieKongrev = tisnenieConstants.tisnenieKongrev
		
		klisheSm = tisnenieConstants.klisheSm
		klisheKongrevSm = tisnenieConstants.klisheKongrevSm
		klisheMin = tisnenieConstants.klisheKongrevMin
		klisheKongrevMin = tisnenieConstants.klisheKongrevMin

		dopSum = Array.new()
		dp = params[:dp].split(/,/)
		
		tirazh = params[:tirazh].to_i

		if params[:paper]
			paperInstance = Paper.find(params[:paper])
			case paperInstance.currency
			when 'd' then paperPrice = dollar*paperInstance.price
			when 'e' then paperPrice = euro*paperInstance.price
			when 'r' then paperPrice = paperInstance.price
			end						
		end

		if params[:nopaper]
			paperPrice = params[:nopaper].to_f
			#percent = 0		
		end

		if(dp[0]=="1")
				dopSum << priladka+tirazh*tisnenieBlint
		end
		if(dp[1]=="1")
				dopSum << priladka+tirazh*tisnenieFolga
		end
		if(dp[2]=="1")
				dopSum << priladka+tirazh*tisnenieKongrev
		end

		remainder = tirazh%formats.formatLists

		if remainder>0
			listCount = tirazh/formats.formatLists+1
		else
			listCount = tirazh/formats.formatLists
		end 

		bumaga = (paperPrice + paperPrice*percent/100)*listCount
		obrabotka = dopSum.sum 
		
		result = bumaga + obrabotka
	
		@tmp1 = "#{(result).round(2)} руб."#obrabotka#dopSum#bumaga#tirazh
		
		render :text => @tmp1

	end
	
end
