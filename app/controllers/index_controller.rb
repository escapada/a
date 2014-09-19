class IndexController < ApplicationController
	def index
		@papers = Paper.find(:all)
	end

	def result
		constants = Constant.find(:first)

		dollar = constants.dollar
		euro = constants.euro
		koeficient = constants.koeficient # множитель для цифровой печати на визитках
		percent = constants.percent
		setFirstColor = constants.setFirstColor
		setNextColor = constants.setNextColor
		prokatPrint = constants.prokatPrint
		setUF = constants.setUF
		prokatUF = constants.prokatUF
		setUFUp = constants.setUFUp
		prokatUFUp = constants.prokatUFUp
		setTisnenie = constants.setTisnenie
		tisnenieBlint = constants.tisnenieBlint
		tisnenieFolga = constants.tisnenieFolga
		tisnenieKongrev = constants.tisnenieKongrev
		klishe = constants.klishe
		termopod = constants.termopod
		obrez = constants.obrez
		kruglenie = constants.kruglenie
		setVyrubka = constants.setVyrubka
		vyrubka = constants.vyrubka
		shtamp = constants.shtamp
		
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
			percent = 0		
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
			dopSum << setUF+tirazh*prokatUF
		end
		if(dp[4]=="1")
			dopSum << setUFUp+tirazh*prokatUFUp
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
	
end
