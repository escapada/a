class IndexController < ApplicationController
	def index
		@papers = Paper.find(:all)
	end

	def result
		if params[:paper]
			paperPrice = Paper.find(params[:paper]).price			
		end
		if params[:nopaper]
			paperPrice = params[:nopaper].to_i		
		end
		

		percent = 30
		setFirstColor = 300
		setNextColor = 150
		prokatPrint = 4
		setUF = 1200
		prokatUF = 5
		setUFUp = 1700
		prokatUFUp = 7
		tisnenieBlint = 3
		setTisnenie = 750
		tisnenieBlint = 3
		tisnenieFolga = 5
		tisnenieKongrev = 5
		klishe = 500
		termopod = 500
		obrez = 300
		kruglenie = 1
		setVyrubka = 750
		vyrubka = 3
		shtamp = 1500
		
		dopSum = Array.new()
		dp = params[:dp].split(/,/)

		color = params[:color]
		tirazh = params[:tirazh].to_i

		nextColorCount = 0
		prokatCount = tirazh/4
		colorCount = 1

		if params[:printer] == "true"
			case tirazh
			when 0..999
				if color == '1'
					print = Cyfravizitka.find(:first, :conditions => "tirazh = '#{tirazh}'").price
				end
				if color == '2'
					print = Cyfravizitka.find(:first, :conditions => "tirazh = '#{tirazh}'").price2			
				end
			when 1000..1499
				tmpCount = tirazh
				if color == '1'
					print = (Cyfravizitka.find(:first, :conditions => "tirazh = '1000'").price)
				end
				if color == '2'
					print = Cyfravizitka.find(:first, :conditions => "tirazh = '1000'").price2			
				end
			when 1500..1999
				if color == '1'
					print = Cyfravizitka.find(:first, :conditions => "tirazh = '1500'").price
				end
				if color == '2'
					print = Cyfravizitka.find(:first, :conditions => "tirazh = '1500'").price2			
				end
			when 2000..2999
			when 3000..3999
			when 4000..4999
			when 5000..9999

			end
			

			#print = setFirstColor + setNextColor*nextColorCount + prokatCount*prokatPrint*colorCount
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
		#print = setFirstColor + setNextColor*nextColorCount + prokatCount*prokatPrint*colorCount
		obrabotka = dopSum.sum 
		result = bumaga + print + obrabotka



		@tmp1 = "#{print} руб."#obrabotka#dopSum#bumaga#tirazh

		#render json: @tmp1
		#render text: @tmp1
		
		render :text => @tmp1

	end
	
end
