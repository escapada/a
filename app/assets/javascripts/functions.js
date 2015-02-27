function resize_monitor() {
//	if(document.body.clientWidth <= 1220){
//		var windowHSize = 1220;
//		var windowVSize = 788;
//	}
//	else if(document.body.clientWidth >= 2048){
//		var windowHSize = 2048;
//	}
//	else{
//		var windowHSize = document.body.clientWidth;
//		var windowVSize = document.body.clientHeight;
//	}
	
	var windowHSize = document.body.clientWidth;
	var windowVSize = document.body.clientHeight;

	/*var fp_wrapHSize = windowHSize-57; было -40. довавили 17px на полосу прокрутки псрава. FF не хотел скролить мышкой. <html> overflow:hidden заменено на auto*/
	var fp_wrapHSize = windowHSize-40;
	var fp_wrapVSize = windowVSize-40;

	var wrapperHSize = (fp_wrapHSize-40)/3;
	var wrapperVSize = (fp_wrapVSize-40)/3;

	//$("#text").text(windowHSize+" : "+windowVSize+" : "+wrapperHSize+" : "+wrapperVSize);
	//$("#fp_wrap").css({"padding-top": 20, "padding-left": 20});
	$("#fp_wrap").css({"padding": 20});
	$("#fp-footer").css({"padding-left": 20, "padding-right": 20, "width": $("#fp_wrap").width()});
	$(".wrapper").css({"width": wrapperHSize, "height": wrapperVSize});
	$(".wrapper_margin").css({"height": wrapperVSize});

	//adaptive resizing for calc (vizitki...)
	if (windowHSize > 1546) {
		$("#contentcolumn").css({"width": 1300});
		$("#footer").css({"width": $("#contentcolumn").outerWidth()});
		$("#hideblockbtn .line").css({"width": 570});
	}
	else if (windowHSize > 1246){
		$("#contentcolumn").css({"width": 980});
		$("#footer").css({"width": $("#contentcolumn").outerWidth()});
		$("#hideblockbtn .line").css({"width": 410});
	}
	else {
		$("#contentcolumn").css({"width": 660});
		$("#footer").css({"width": $("#contentcolumn").outerWidth()});
		$("#hideblockbtn .line").css({"width": 250});
	}
	//logo+boxes scalling
	wrapheight = $(".wrapper").height();
	wrapwidth = $(".wrapper").width();
	if (wrapheight<194) {
	 $("#logo_img").height(wrapheight-30);
	}
	if (wrapheight<211) {
	 $("#fp_2_img").height(wrapheight-20);
	}
	wrapheight = $(".wrapper").height();
	if (wrapheight<205 || wrapwidth<344) {
	 $(".link").css({"font-size": "14px", "line-height": "18px"});
	}
	else{$(".link").css({"font-size": "21px", "line-height": "25px"});}
	//end of logo+boxes scalling

}
function clear_cash() {
	$("[name='material']").val('');
	$("#material-options").show(0);
	$("#select-color-options").show(0);
	$(".selectoption_material_input").val('');
	$("[name='color']").val('');
	$("#select-tirazh").val('Тираж');
	$("[name='dp1']").val(0);
	$("[name='dp2']").val(0);
	$("[name='dp3']").val(0);
	$("[name='dp4']").val(0);
	$("[name='dp5']").val(0);
	$("[name='dp6']").val(0);
	$("[name='dp7']").val(0);
	$("[name='dp8']").val(0);
	$("[name='dp9']").val(0);
	$("[name='klishe_blint']").val(0);
	$("[name='klishe_folga']").val(0);
	$("[name='klishe_kongrev']").val(0);
	$("[name='vyrubka']").val(0);
}
function tisnenieOrVyrubkaChecked(dp, checked) {						//$(this).children("input").attr('name')
	if (dp == 'dp1') {
		if(checked){
			$("#notice1").show(0);
		}
		else{
			$("#notice1").hide(0);
			if ($("input[name='klishe_blint']").parent().hasClass('selected')) {
				$("input[name='klishe_blint']").parent().removeClass('selected');
				$("input[name='klishe_blint']").val(0);
			}
		}
	}
		if (dp == 'dp2') {
		if(checked){
			$("#notice2").show(0);
		}
		else{
			$("#notice2").hide(0);
			if ($("input[name='klishe_folga']").parent().hasClass('selected')) {
				$("input[name='klishe_folga']").parent().removeClass('selected');
				$("input[name='klishe_folga']").val(0);
			}
		}
	}
	if (dp == 'dp3') {
		if(checked){
			$("#notice3").show(0);
		}
		else{
			$("#notice3").hide(0);
			if ($("input[name='klishe_kongrev']").parent().hasClass('selected')) {
				$("input[name='klishe_kongrev']").parent().removeClass('selected');
				$("input[name='klishe_kongrev']").val(0);
			}
		}
	}
	if (dp == 'dp9') {
		if(checked){
			$("#notice4").show(0);
		}
		else{
			$("#notice4").hide(0);
			if ($("input[name='vyrubka']").parent().hasClass('selected')) {
				$("input[name='vyrubka']").parent().removeClass('selected');
				$("input[name='vyrubka']").val(0);
			}
		}
	}
}